# -*- coding: utf-8 -*-
import numpy
import cv2
import myhdl_top


def run_opencv():
    src = cv2.imread('../../image/twittan/twittan.jpg')
    dst = src.copy()

    roi_x = 100
    roi_y = 100
    roi_w = 150
    roi_h = 200

    dst[roi_y:roi_y + roi_h, roi_x:roi_x + roi_w] = cv2.blur(src[roi_y:roi_y + roi_h, roi_x:roi_x + roi_w], (5, 5),
                                                             (-1, -1))
    print("image size:width = %d, height = %d" % (dst.shape[1], dst.shape[0]))

    cv2.imwrite('twi_blur_cv.jpg', dst)


run_opencv()
myhdl_top.run_sim()


