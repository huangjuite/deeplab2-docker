
import os
import cv2
import argparse
import numpy as np
import matplotlib.pyplot as plt
from collections import defaultdict
from shutil import copyfile
from tqdm import tqdm
from PIL import Image


def move_img(f, current_folder, save_folder):

    of = os.path.join(current_folder, f)
    nf = os.path.join(save_folder, f)
    copyfile(of, nf)


def merge_class_ins(ins, cla, current_folder, save_folder):
    f = ins[:13]+'_gtFine_instanceTrainIds.png'
    ins = os.path.join(current_folder, ins)
    cla = os.path.join(current_folder, cla)

    ins_img = np.array(Image.open(ins)).astype(np.int32)
    cla_img = np.array(Image.open(cla)).astype(np.int32)

    train_img = cla_img * 1000 + ins_img

    Image.fromarray(train_img).save(os.path.join(save_folder, f))

    # print(np.max(cla_img))

    # plt.imshow(cla_img)
    # plt.show()

    # print(np.max(ins_img))

    # plt.imshow(ins_img)
    # plt.show()


def rename_depth(f: str, current_folder, save_folder):
    nf = f.split('_')[:-1]
    nf = '_'.join(nf)+'.png'
    f = os.path.join(current_folder, f)
    nf = os.path.join(save_folder, nf)
    copyfile(f, nf)


def find_f(key, list_f):
    for f in list_f:
        if key in f:
            return f


if __name__ == '__main__':
    folder = '/media/cruw/My Passport/deeplab'
    vip_folder = os.path.join(folder, 'video_sequence')
    for dataset in os.listdir(vip_folder):
        files = os.listdir(os.path.join(vip_folder, dataset))
        files.sort()

        file_dict = defaultdict(lambda: [])

        for f in files:
            frame = int(f[7:13])
            file_dict[frame].append(f)

        save_folder = os.path.join(folder, 'dvps', dataset)
        current_folder = os.path.join(vip_folder, dataset)
        os.makedirs(save_folder, exist_ok=True)

        for frame, fs in tqdm(file_dict.items()):
            d_file = find_f('depth', fs)
            rename_depth(d_file, current_folder, save_folder)
            ins = find_f('instance', fs)
            cla = find_f('class', fs)
            merge_class_ins(ins, cla, current_folder, save_folder)
            img = find_f('leftImg', fs)
            move_img(img, current_folder, save_folder)
