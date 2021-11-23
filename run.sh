#! /bin/bash

cd /root/bmtt-deeplab2/deeplab2

CONFIG_FILE=/root/bmtt-deeplab2/ViP-DeepLab/resnet50_beta_os32.textproto
BASE_MODEL_DIRECTORY=/root/bmtt-deeplab2/ViP-DeepLab/model
MODE=eval

python3 trainer/train.py \
    --config_file=${CONFIG_FILE} \
    --mode=${MODE} \
    --model_dir=${BASE_MODEL_DIRECTORY} \
    --num_gpus=1
