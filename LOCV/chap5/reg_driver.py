# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import *

def reg_driver_top(
        clk, reset,
        reg_start, reg_end,
        reg_width, reg_height,
        reg_roi_x, reg_roi_y, reg_rot_h, reg_rot_w
        ):

    @instance
    def regDriver():
        while reset == 0:
            yield clk.posedge
        while reset == 1:
            yield clk.posedge

        reg_width.next = 557
        reg_height.next = 358
        reg_roi_x.next = 100
        reg_roi_y.next = 100
        reg_rot_h.next = 200
        reg_rot_h.next = 200
        reg_rot_w.next = 150
        yield clk.posedge

        reg_start.next = 1
        yield clk.posedge
        reg_start.next = 0
        yield clk.posedge

        while reg_end == 0:
            yield clk.posedge

        print("end == 1")
        yield clk.posedge

    return regDriver
