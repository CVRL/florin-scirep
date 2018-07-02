from utils import threshold_bradley3d, load_volume, imcomplement, save_imgs
from utils import threshold_bradley_nd, lide
from utils import custom_mask, load_hdf5, save_hdf5

import argparse
import os
import time

import numpy as np
from scipy.signal import wiener
from scipy.ndimage import binary_dilation, binary_erosion, binary_fill_holes, generate_binary_structure, binary_opening, binary_closing
from skimage.exposure import rescale_intensity, equalize_hist
from skimage.measure import label, regionprops
from skimage.morphology import remove_small_objects
from skimage.io import imread

import matplotlib.pyplot as plt


def parse_args(args=None):
    parser = argparse.ArgumentParser()

    parser.add_argument('-i', '--input',
                        help='path or glob to image volume',
                        type=str
                        )

    parser.add_argument('-o', '--output',
                        help='path to save images to',
                        type=str
                        )

    parser.add_argument('-t', '--threshold',
                        help='threshold for bradley method',
                        type=float
                        )

    parser.add_argument('--shape',
                        type=int,
                        nargs='*',
                        default=[]
                        )

    parser.add_argument('--step',
                        type=int,
                        nargs='*',
                        default=[]
                        )

    parser.add_argument('--show',
                        help='show intermediate output',
                        action='store_true'
                        )

    return parser.parse_args(args)


def main():
    args = parse_args()

    start = time.time()

    print("Loading image volume")
    vol = load_volume(args.input)

    if args.show:
        plt.imshow(vol[0], cmap='Greys_r')
        plt.show()

    print("Prepping threshold subvolume shape")
    if len(args.shape) < len(vol.shape):
        shape = list(vol.shape[:len(vol.shape) - len(args.shape)])
        shape.extend(args.shape)
    else:
        shape = args.shape

    if len(args.step) < len(shape):
        step = list(vol.shape[:len(vol.shape) - len(args.step)])
        step.extend(args.step)
    else:
        step = args.step

    print("Thresholding subvolumes")
    step = args.step

    thresh = np.zeros(vol.shape)
    for i in range(0, vol.shape[0], step[0] if step else vol.shape[0]):
        endi = i + shape[0] if i + shape[0] < vol.shape[0] else vol.shape[0]
        for j in range(0, vol.shape[1], step[1] if step else vol.shape[1]):
            endj = j + shape[1] if j + shape[1] < vol.shape[1] else vol.shape[1]
            for k in range(0, vol.shape[2], step[2] if step else vol.shape[2]):
                endk = k + shape[2] if k + shape[2] < vol.shape[2] else vol.shape[2]
                subvol = np.copy(vol[i:endi, j:endj, k:endk])
                subvol = threshold_bradley_nd(subvol, s=(4, shape[1], shape[2]), t=args.threshold)
                subvol = np.abs(1 - subvol) if np.max(subvol) > 0 else subvol
                subvol = binary_opening(subvol)
                subvol = binary_fill_holes(subvol)
                subvol[subvol > 0] = 1
                thresh[i:endi, j:endj, k:endk] += subvol

    if args.show:
        plt.imshow(thresh[0], cmap='Greys_r')
        plt.show()
    thresh[thresh > 0] = 255
    print("Saving segmentation")
    save_imgs(thresh, args.output)
    print("Running Time: {}s".format(time.time() - start))


if __name__ == "__main__":
    main()
