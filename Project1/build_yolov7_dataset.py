import os, ceg5301_util, sys
import numpy as np
import pandas as pd
# fix the numpy random seed
np.random.seed(66)

sys.path.append("json2yolo_ceg5301")
sys.path.append("fathomnet_2023")
from pylabel import importer
from fathomnet_2023.download_images import download_datasets
from json2yolo_ceg5301.general_json2yolo import convert_coco_json

scriptPath = ceg5301_util.get_script_root()
datasetConfigDirPath = os.path.join(scriptPath, "fathomnet_2023", "train")
datasetConfigPath = os.path.join(datasetConfigDirPath, "train.json")
datasetLabelPath = os.path.join(scriptPath, "yolov7_ceg5301", "fathomnet_2023_dataset")
datasetDataPath = os.path.join(
    scriptPath, "yolov7_ceg5301", "fathomnet_2023_dataset", "images", "train"
)

# split datasets into train & validation set
def split_train_val(superKeyName: list, valRatio: float = 0.2):
    # specify the path of raw datasets
    datasetLabelRawPath = os.path.join(datasetLabelPath, "labels", "train")
    datasetImgRawPath = datasetDataPath
    # specify the path of generated datasets
    datasetTrainLabelPath = os.path.join(datasetLabelPath, "labels", "train_ceg5301")
    datasetValLabelPath = os.path.join(datasetLabelPath, "labels", "val_ceg5301")
    datasetTrainImgPath = os.path.join(datasetLabelPath, "images", "train_ceg5301")
    datasetValImgPath = os.path.join(datasetLabelPath, "images", "val_ceg5301")
    # create the clean directory
    ceg5301_util.clean_dir(datasetTrainLabelPath)
    ceg5301_util.clean_dir(datasetValLabelPath)
    ceg5301_util.clean_dir(datasetTrainImgPath)
    ceg5301_util.clean_dir(datasetValImgPath)
    # get list of labels/images
    labelList = np.array(sorted(ceg5301_util.get_file_list(datasetLabelRawPath, [".txt"])))
    imgList = np.array(sorted(ceg5301_util.get_file_list(datasetImgRawPath, [".png"])))
    assert(len(labelList) == len(imgList))
    # calculate the number of train/val samples
    numTotalSamples = len(labelList)
    numValSamples = int(round(valRatio * numTotalSamples))
    numTrainSamples = numTotalSamples - numValSamples
    # split the raw dataset
    sampleIndex = np.linspace(0, numTotalSamples - 1, numTotalSamples, dtype=np.int64)
    # randomly choose the train/val index
    np.random.shuffle(sampleIndex)
    trainLabelList = labelList[sampleIndex[0:numTrainSamples]]
    valLabelList = labelList[sampleIndex[numTrainSamples:]]
    trainImgList = imgList[sampleIndex[0:numTrainSamples]]
    valImgList = imgList[sampleIndex[numTrainSamples:]]
    # hint users
    print(f"Raw Dataset Labels Path ==> {datasetLabelRawPath}")
    print(f"Raw Dataset Images Path ==> {datasetImgRawPath}")
    print(f"Total Number of Samples: {numTotalSamples} ==> Train: {numTrainSamples}, Validation: {numValSamples}")
    # copy train labels and images
    print("Generating Train Labels and Images...")
    for i in range(numTrainSamples):
        labelPath = trainLabelList[i]
        imgPath = trainImgList[i]
        labelFileName = os.path.basename(labelPath)
        imgFileName = os.path.basename(imgPath)
        assert(os.path.splitext(labelFileName)[0] == os.path.splitext(imgFileName)[0])
        newLabelPath = os.path.join(datasetTrainLabelPath, labelFileName)
        newImgPath = os.path.join(datasetTrainImgPath, imgFileName)
        # real copy command (currently support linux only)
        _, _, retCode = ceg5301_util.exec_shell_cmd(f"cp {labelPath} {newLabelPath}")
        assert(retCode == 0)
        _, _, retCode = ceg5301_util.exec_shell_cmd(f"cp {imgPath} {newImgPath}")

    # copy validation labels
    print("Generating Validation Labels and Images")
    for i in range(numValSamples):
        labelPath = valLabelList[i]
        imgPath = valImgList[i]
        labelFileName = os.path.basename(labelPath)
        imgFileName = os.path.basename(imgPath)
        assert(os.path.splitext(labelFileName)[0] == os.path.splitext(imgFileName)[0])
        newLabelPath = os.path.join(datasetValLabelPath, labelFileName)
        newImgPath = os.path.join(datasetValImgPath, imgFileName)
        # real copy command (currently support linux only)
        _, _, retCode = ceg5301_util.exec_shell_cmd(f"cp {labelPath} {newLabelPath}")
        assert(retCode == 0)
        _, _, retCode = ceg5301_util.exec_shell_cmd(f"cp {imgPath} {newImgPath}")

    # generating train/validation config file
    trainImgListFile = os.path.join(datasetLabelPath, "train_ceg5301.txt")
    valImgListFile = os.path.join(datasetLabelPath, "val_ceg5301.txt")
    relativeTrainImgDirPath = os.path.join(".", "images", "train_ceg5301")
    relativeValImgDirPath = os.path.join(".", "images", "val_ceg5301")
    print("Generating train/validation config file...")
    print(f"Writing to ==> {trainImgListFile}")
    with open(trainImgListFile, "w") as file:
        for i in range(numTrainSamples):
            imgPath = trainImgList[i]
            imgFileName = os.path.basename(imgPath)
            relativeImgPath = os.path.join(relativeTrainImgDirPath, imgFileName)
            file.write(f"{relativeImgPath}\n")
    print(f"Writing to ==> {valImgListFile}")
    with open(valImgListFile, "w") as file:
        for i in range(numValSamples):
            imgPath = valImgList[i]
            imgFileName = os.path.basename(imgPath)
            relativeImgPath = os.path.join(relativeValImgDirPath, imgFileName)
            file.write(f"{relativeImgPath}\n")

    # generating yaml config for train
    print("Generating yaml config for train...")
    trainYamlConfigFile = os.path.join(scriptPath, "yolov7_ceg5301", "data", "ceg5301_custom.yaml")
    trainConfigDict = {
        "train": os.path.join(".", "fathomnet_2023_dataset", "train_ceg5301.txt"),
        "val": os.path.join(".", "fathomnet_2023_dataset", "val_ceg5301.txt"),
        "test": os.path.join(".", "fathomnet_2023_dataset", "val_ceg5301.txt"),
        "nc": len(superKeyName),
        "names": superKeyName
    }
    print(f"Writing to ==> {trainYamlConfigFile}")
    ceg5301_util.dump_config(trainYamlConfigFile, trainConfigDict, default_flow_style = True)
    with open(trainYamlConfigFile, "a") as file:
        file.write("\n# Generated by CEG5301 Project1 Scripts Automatically")
    print("Done")
    
def get_super_cat_map(keyPath: str):
    pdData = pd.read_csv(keyPath)
    keyDict = {}
    keyMap = []
    keyName = []
    keyIdx = -1
    for rowIdx in range(len(pdData)):
        if pdData.loc[rowIdx, "supercat"] not in keyDict:
            keyIdx += 1
            keyDict[pdData.loc[rowIdx, "supercat"]] = keyIdx
            keyName.append(pdData.loc[rowIdx, "supercat"])
            
        keyMap.append(keyIdx)
    keyMapFilePath = os.path.join(os.path.dirname(keyPath), "category_key_map.yaml")
    ceg5301_util.dump_config(keyMapFilePath, keyDict)
    with open(keyMapFilePath, "a") as file:
        file.write("\n# Generated by CEG5301 Project1 Scripts Automatically")
    return keyMap, keyName


if __name__ == "__main__":

    # map to super-category
    superKeyMap, superKeyName = get_super_cat_map(os.path.join(scriptPath, "fathomnet_2023", "category_key.csv"))
    ceg5301_util.clean_dir(os.path.join(datasetLabelPath, "labels", "train"))
    convert_coco_json(datasetConfigDirPath, datasetLabelPath, keyMap=superKeyMap)

    ###### Enable if necessary ######
    # increase the `numProc` appropriately to speed up the download
    # ceg5301_util.clean_dir(datasetDataPath)
    # download_datasets(datasetConfigPath, datasetDataPath, numProc=64)
    #################################

    # download pre-trained model for transer-learning
    ceg5301_util.download_to_dir("https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7_training.pt", datasetLabelPath)
    # split train/val dataset
    split_train_val(superKeyName)
