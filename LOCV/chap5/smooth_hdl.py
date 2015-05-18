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
        reg_roi_x, reg_roi_y, reg_rot_h, reg_rot_w
    ):

    state = Signal(t_State.IDLE)

    @instance
    def main_proc():
        while True:
            if state == t_State.RUNNING:
                for y in range(reg_height):
                    for x in range(reg_width):
                        radr.next = adr(x, y)
                        yield clk.posedge
                        rout.next = rin
                        gout.next = gin
                        bout.next = bin
                        wen.next = 1
                        yield  clk.posedge
                        wen.next = 0
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

