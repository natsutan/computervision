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
        x, y = adr_dec(radr)
        read_r.next = clop_8bit(src[y][x][0])
        read_g.next = clop_8bit(src[y][x][1])
        read_b.next = clop_8bit(src[y][x][2])


    @instance
    def mem_write():
        while True:
            if wen == 1:
                x, y = adr_dec(wadr)
                dst[y][x][0] = write_r
                dst[y][x][1] = write_g
                dst[y][x][2] = write_b
            yield clk.posedge



    return mem_read, mem_write

def write_image():
    cv2.imwrite('twi_blur_rtl.jpg', dst)

def adr_dec(adr):
    width = dst.shape[1]
    x = int(adr) % width
    y = int(adr) / width
    return x, y

def clop_8bit(x):
    if x >= 255:
        return 255

    return int(x)
