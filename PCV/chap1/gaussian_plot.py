# -*- coding: utf-8 -*-
from pylab import *
from scipy.misc import imsave

xs = arange(-10.0, 10.0, 0.01)
ys = []
sigma = 5.0

def gaussian_derivative(x):
    return (x/(sqrt(2*pi)*sigma*sigma*sigma)) * exp(-(x*x)/(2*sigma*sigma))

def gaussian(x):
    return (1/sqrt(2*pi*sigma*sigma)) * exp(-(x*x)/(2*sigma*sigma))

for x in xs:
#    y = (1/sqrt(2*pi*sigma*sigma)) * exp(-(x*x)/(2*sigma*sigma))
    y = gaussian_derivative(x)
    ys.append(y)

for x in arange(-5, 5, 1):
    y = gaussian(x)
    print("%f, %f" % (x, y))


plot(xs,ys)

show()

