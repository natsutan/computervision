# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import *
import numpy
import cv2


def mem_top(
        clk, reset,
        read_r, read_g, read_b, radr,
        write_r, write_g, write_b, wadr, wen):

    src = cv2.imread('../../image/twittan/twittan.jpg')
    dst = numpy.zeros(src.shape)


    def mem_read():
        
 
 
    def mem_write():
        while True:
            if wen == 1:
                dst[wadr] = (write_r. write_g, write_b)
            yield clk.posedge

    def write():
        cv2.imwrite('twi_blur_rtl.jpg', dst)


    return mem_read, mem_write

