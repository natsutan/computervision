# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import *
import numpy
import cv2

dst = None

def mem_top(
        clk, reset,
        read_r, read_g, read_b, radr,
        write_r, write_g, write_b, wadr, wen):
    global dst

    src = cv2.imread('../../image/twittan/twittan.jpg')
    dst = numpy.zeros(src.shape)

    @always_comb
    def mem_read():
        #global read_r, read_g, read_b
        read_r.next = src[0][radr][0]
        read_g.next = src[0][radr][1]
        read_b.next = src[0][radr][2]


 
    @instance
    def mem_write():
        while True:
            if wen == 1:
                dst[wadr][0] = write_r
                dst[wadr][1] = write_g
                dst[wadr][2] = write_b
            yield clk.posedge



    return mem_read, mem_write

def write_image():
    cv2.imwrite('twi_blur_rtl.jpg', dst)

