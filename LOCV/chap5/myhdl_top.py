# -*- coding: utf-8 -*-
__author__ = 'natu'
from myhdl import Signal, delay, always, now, Simulation


def run_sim():
    inst = HelloWorld()
    sim = Simulation(inst)
    sim.run(30)



def HelloWorld():

    interval = delay(10)

    @always(interval)
    def sayHello():
        print "%s Hello World!" % now()

    return sayHello


