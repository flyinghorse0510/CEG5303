# Taks 2 Instructions
1. Download dataset and extract it to `Project1/yolov7_ceg5301/fathomnet_2023_dataset`
2. Run Python script to build and generate the dataset and config files for trainning:
```bash
python3 build_yolov7_dataset.py
```
3. Train:
> Change `--device` and `--batch-size` on your demand
```bash
python3 train.py --workers 8 --device cpu --batch-size 16 --data data/ceg5301_custom.yaml --img 640 640 --cfg cfg/training/yolov7.yaml --weights 'fathomnet_2023_dataset/yolov7_training.pt' --name yolov7-custom --hyp data/hyp.scratch.custom.yaml
```

4. Attack
```bash
python3 test_attack.py --data data/ceg5301_custom.yaml --cfg cfg/training/yolov7.yaml --hyp data/hyp.scratch.custom.yaml --img 640 --batch 24 --conf 0.4 --iou 0.65 --weights fathomnet.pt --name yolov7_640_val --attack --epsilon 0.01 --device 0
```

**If you find any corrupted iamges, you can enable the code in the `build_yolov7_dataset.py` scirpt calling `download_datasets` function which will download the whole dataset from official websites again**