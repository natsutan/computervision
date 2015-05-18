# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import Signal, delay, always, now, Simulation, instance, intbv, traceSignals, ResetSignal
from smooth_hdl import smoother_top
from reg_driver import reg_driver_top
from mem import mem_top

# paramter
p_max_x = 1024
p_max_y = 1024

def run_sim():
#    clk = Signal(0)     # 0は初期値
#    clkdriver_inst = ClkDeriver(clk)
#    hello_inst = HelloWorld(clk)
#    sim = Simulation(clkdriver_inst, hello_inst)
    inst = traceSignals(env)
    sim = Simulation(inst)

    sim.run(300)


def env():
    # clk
    clk = Signal(bool(0))
    uClkDriver = ClkDriver(clk)
    reset = ResetSignal(0, active=True, async=True)

    uResetDriver = ResetDriver(clk, reset)

    # input port
    rin = Signal(intbv(0, min=0, max=255))
    gin = Signal(intbv(0, min=0, max=255))
    bin = Signal(intbv(0, min=0, max=255))
    radr = Signal(intbv(0, min=0, max=p_max_x * p_max_y))

    # output port
    rout = Signal(intbv(0, min = 0, max = 255))
    gout = Signal(intbv(0, min = 0, max = 255))
    bout = Signal(intbv(0, min = 0, max = 255))
    wadr = Signal(intbv(0, min = 0, max = p_max_x * p_max_y))
    wen  = Signal(intbv(bool(0)))

    # registers
    reg_start = Signal(intbv(bool(0)))
    reg_end = Signal(intbv(bool(0)))
    reg_width = Signal(intbv(0, min=0, max=p_max_x))
    reg_height = Signal(intbv(0, min=0, max=p_max_y))
    reg_roi_x = Signal(intbv(0, min=0, max=p_max_x))
    reg_roi_y = Signal(intbv(0, min=0, max=p_max_y))
    reg_rot_w = Signal(intbv(0, min=0, max=p_max_x))
    reg_rot_h = Signal(intbv(0, min=0, max=p_max_y))

    uRegDriver = reg_driver_top(
        clk, reset,
        reg_start, reg_end,
        reg_width, reg_height,
        reg_roi_x, reg_roi_y, reg_rot_h, reg_rot_w
        )

    uMem = mem_top(
        clk = clk, reset = reset,
        read_r = rin, read_g = gin, read_b = bin, radr = radr,
        write_r = rout, write_g = gout, write_b = bout, wadr = wadr, wen = wen
    )

    uDut = smoother_top(
        clk, reset,
        rin, gin, bin, radr,
        rout, gout, bout, wadr, wen,
        reg_start, reg_end,
        reg_width, reg_height,
        reg_roi_x, reg_roi_y, reg_rot_h, reg_rot_w
    )

    return uClkDriver, uResetDriver, uRegDriver, uMem, uDut



def greedings():
    clk1 = Signal(0)
    clk2 = Signal(0)

    clkdriver1 = ClkDriver(clk1)
    clkdriver2 = ClkDriver(clk = clk2, period=19)
    hello1 = Hello(clk=clk1)
    hello2 = Hello(to="MyHDL", clk = clk2)

    return clkdriver1, clkdriver2, hello1, hello2



def ClkDriver(clk, period = 20):
    lowTime = int(period/2)
    highTime = period - lowTime

    @instance
    def driveClk():
        while True:
            yield delay(lowTime)
            clk.next = 1
            yield delay(highTime)
            clk.next = 0

    return driveClk

def ResetDriver(clk, reset):
    lowTime = 2
    highTime = 1

    @instance
    def driveReset():
        reset.next = 0
        for i in range(lowTime):
            yield clk.posedge
        reset.next = 1
        for i in range(highTime):
            yield clk.posedge
        reset.next = 0
        yield clk.posedge


    return driveReset

def Hello(clk, to="World!"):


    @always(clk.posedge)
    def sayHello():
        print "%s Hello %s" % (now(), to)

    return sayHello


