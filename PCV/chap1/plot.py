# -*- coding: utf-8 -*-
__author__ = 'natu'

from PIL import Image
from pylab import *
import matplotlib.font_manager

prop = matplotlib.font_manager.FontProperties(fname=r'c:\windows\fonts\msgothic.ttc')

im = array(Image.open('twittan.jpg'))
imshow(im)

x = [100, 100, 400, 400]
y = [200, 500, 200, 500]

plot(x, y, 'r*')
plot(x[:2], y[:2])

title('Plotting: ついったん', fontproperties = prop)
show()