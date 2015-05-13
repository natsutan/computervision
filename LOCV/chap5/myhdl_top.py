# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import Signal, delay, always, now, Simulation, instance, intbv, channel
import smooth_hdl

# paramter
p_max_x = 1024
p_max_y = 1024

def run_sim():
#    clk = Signal(0)     # 0は初期値
#    clkdriver_inst = ClkDeriver(clk)
#    hello_inst = HelloWorld(clk)
#    sim = Simulation(clkdriver_inst, hello_inst)

    inst = env()
    sim = Simulation(inst)

    sim.run(50)


def env():
    # clk
    clk = Signal(0)
    uClkDriver = ClkDeriver(clk)

    # input port
    rin = Signal(intbv(0, min = 0, max = 255))
    gin = Signal(intbv(0, min = 0, max = 255))
    bin = Signal(intbv(0, min = 0, max = 255))
    radr = Signal(intbv(0, min = 0, max = p_max_x * p_max_y))
    inport_ch = channel(rin, gin, bin, radr)

    # output port
    rout = Signal(intbv(0, min = 0, max = 255))
    gout = Signal(intbv(0, min = 0, max = 255))
    bout = Signal(intbv(0, min = 0, max = 255))
    wadr = Signal(intbv(0, min = 0, max = p_max_x * p_max_y))
    wen  = Signal(intbv(0))
    outport_ch = channel(rout, gout, bout, wadr, wen)

    # registers
    reg =


    return uClkDriver



def greedings():
    clk1 = Signal(0)
    clk2 = Signal(0)

    clkdriver1 = ClkDeriver(clk1)
    clkdriver2 = ClkDeriver(clk = clk2, period=19)
    hello1 = Hello(clk=clk1)
    hello2 = Hello(to="MyHDL", clk = clk2)ｓ

    return clkdriver1, clkdriver2, hello1, hello2



def ClkDeriver(clk, period = 20):
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

def Hello(clk, to="World!"):


    @always(clk.posedge)
    def sayHello():
        print "%s Hello %s" % (now(), to)

    return sayHello


