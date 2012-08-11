# -*- coding: utf-8 -*-
from pylab import *
from scipy.misc import imsave

def gaussian_derivative(x):
    return (x/(sqrt(2*pi)*sigma*sigma*sigma)) * exp(-(x*x)/(2*sigma*sigma))

xs = arange(-20.0, 20.0, 0.01)
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
<<<<<<< HEAD
    y = gaussian_derivative(x)
    print("%f, %f" % (x, y ) )

=======
    y = gaussian(x)
    print("%f, %f" % (x, y))
>>>>>>> ec1383e9963df8d8e4eeb7057f261ffff74f2448


plot(xs,ys)

show()

