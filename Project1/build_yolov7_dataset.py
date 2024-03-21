import os, ceg5301_util, sys

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
    scriptPath, "yolov7_ceg5301", "fathomnet_2023_dataset", "images"
)

if __name__ == "__main__":
    ceg5301_util.create_dir(datasetLabelPath)
    ceg5301_util.create_dir(datasetDataPath)
    convert_coco_json(datasetConfigDirPath, datasetLabelPath)
    # increase the `numProc` appropriately to speed up the download
    download_datasets(datasetConfigPath, datasetDataPath, numProc=32)
