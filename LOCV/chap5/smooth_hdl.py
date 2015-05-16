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


    return fsm

