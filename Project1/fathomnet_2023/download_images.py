# -*- coding: utf-8 -*-
"""
download_images

Script to retrieve images for the 2023 FathomNet out-of-sample challenge as part of FGVC 10. 

Assumes COCO formated annotation file has been download from http://www.kaggle.com/competitions/fathomnet-out-of-sample-detection
"""
# Author: Eric Orenstein (eorenstein@mbari.org)

import os
import sys
import glob
import json
import requests
import logging
import argparse
import progressbar
import pandas as pd
from multiprocessing import Process, Queue, Pool
from shutil import copyfileobj


def download_imgs(img):

    name = img[0]
    url = img[1]
    outdir = img[2]

    file_name = os.path.join(
        outdir, name
    )

    # only download if the image does not exist in the outdir
    if not os.path.exists(file_name):
        resp = requests.get(url, stream=True)
        resp.raw.decode_content = True
        with open(file_name, 'wb') as f:
            copyfileobj(resp.raw, f)


def download_datasets(dataset: str = None, outputPath: str = None, numProc = 32):
    global downloadImg
    logging.basicConfig(level=logging.INFO)
    
    logging.info(f'opening {dataset}')
    logging.info(f"using {numProc} Processes simultaneously")
    processPool = Pool(numProc)

    with open(dataset, 'r') as ff:
        dataset = json.load(ff)

    ims = pd.DataFrame(dataset['images'])

    logging.info(f'retrieving {ims.shape[0]} images')

    ims = list(zip(ims['file_name'].to_list(), ims['coco_url'].to_list()))
    # print(ims)
    ims = [list(task) + [outputPath] for task in ims]
    # print(ims)
    # download images with process pool
    processPool.map(download_imgs, ims)
    # clean and exit
    processPool.close()
    processPool.join()
    

if __name__=="__main__":

    parser = argparse.ArgumentParser(description="Download images from a COCO annotation file")
    parser.add_argument('dataset', type=str, help='Path to json COCO annotation file')
    parser.add_argument('--outpath', type=str, default=None, help='Path to desired output folder')

    args = parser.parse_args()
    download_datasets(args.dataset, args.outpath)

    
