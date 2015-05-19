# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import *

t_State = enum('IDLE', 'RUNNING')

def smoother_top(
        clk, reset,
        rin, gin, bin, radr,
        rout, gout, bout, wadr, wen,
        reg_start, reg_end,
        reg_width, reg_height,
        reg_roi_x, reg_roi_y, reg_roi_h, reg_roi_w
    ):

    state = Signal(t_State.IDLE)

    @instance
    def main_proc():
        while 1:
            if state == t_State.RUNNING:
                for y in range(reg_height):
                    print("y = %d" % y)
                    for x in range(reg_width):
                        if reg_roi_x <= x and x < reg_roi_x + reg_roi_w and reg_roi_y <= y and y < reg_roi_y + reg_roi_h:
                            # ROI
                            sum_r = 0
                            sum_g = 0
                            sum_b = 0
                            for ry in range(-2,3):
                                for rx in range(-2,3):
                                    radr.next = adr(x + rx, y + ry)
                                    yield  clk.posedge
                                    sum_r = sum_r + rin
                                    sum_g = sum_g + gin
                                    sum_b = sum_b + bin
                                    yield  clk.posedge
                            wadr.next = adr(x, y)
                            rout.next = sum_r // 25
                            gout.next = sum_g // 25
                            bout.next = sum_b // 25
                            wen.next = 1
                            yield  clk.posedge
                            wen.next = 0
                        else:
                            radr.next = adr(x, y)
                            yield  clk.posedge
                            wadr.next = adr(x, y)
                            rout.next = rin
                            gout.next = gin
                            bout.next = bin
                            wen.next = 1
                            yield  clk.posedge
                            wen.next = 0
                reg_end.next = 1
                yield  clk.posedge

            yield  clk.posedge


    def adr(x, y):
        return y * reg_width + x

    @always_seq(clk.posedge, reset=reset)
    def fsm():
        if state == t_State.IDLE:
            if reg_start == 1:
                state.next = t_State.RUNNING
        elif state == t_State.RUNNING:
            if reg_end == 1:
                state.next = t_State.IDLE
        else:
            raise ValueError("Undefined state")


    return fsm, main_proc

