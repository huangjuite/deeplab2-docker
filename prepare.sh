#! /bin/bash

cd /root/bmtt-deeplab2/deeplab2

DVPS_ROOT=/root/bmtt-deeplab2/deeplab2/dataset/dvps
OUTPUT_DIR=/root/bmtt-deeplab2/deeplab2/dataset/tf_record
PANOPTIC_DIVISOR=1000

python3 data/build_dvps_data.py \
    --dvps_root=${DVPS_ROOT} \
    --output_dir=${OUTPUT_DIR} \
    --panoptic_divisor=${PANOPTIC_DIVISOR}
