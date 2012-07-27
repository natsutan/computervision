# -*- coding: utf-8 -*-
__author__ = 'Natsutani'
import os
from PIL import Image
from numpy import *
from scipy.ndimage import filters
from scipy.misc import imsave
import scipy

# Tkinterの設定
# http://qiita.com/items/0a79c3c6d6b730f841ee
os.environ['TCL_LIBRARY'] = 'C:/Python32/tcl/tcl8.5'
os.environ['TK_LIBRARY'] = 'C:/Python32/tcl/tk8.5'

im = array(Image.open('twittan.jpg'))
im2 = zeros(im.shape)
for i in range(3):
    im2[:,:,i] = filters.gaussian_filter(im[:,:,i],5)

imsave('twittan_g.jpg', im2.astype('uint8'))
