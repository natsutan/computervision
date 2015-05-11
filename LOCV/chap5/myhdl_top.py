# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import Signal, delay, always, now, Simulation, instance


def run_sim():
#    clk = Signal(0)     # 0は初期値
#    clkdriver_inst = ClkDeriver(clk)
#    hello_inst = HelloWorld(clk)
#    sim = Simulation(clkdriver_inst, hello_inst)

    inst = greedings()
    sim = Simulation(inst)

    sim.run(50)


def greedings():
    clk1 = Signal(0)
    clk2 = Signal(0)

    clkdriver1 = ClkDeriver(clk1)
    clkdriver2 = ClkDeriver(clk = clk2, period=19)
    hello1 = Hello(clk=clk1)
    hello2 = Hello(to="MyHDL", clk = clk2)

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


