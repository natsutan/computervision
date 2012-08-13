# -*- coding: utf-8 -*-
# # Sobelフィルター
__author__ = 'Natsutani'
from PIL import Image
from numpy import *
import scipy
from scipy.ndimage import filters

im = array(Image.open('twittan.jpg').convert('L'))

imx = zeros(im.shape)
filters.sobel(im,1,imx)
imy = zeros(im.shape)
filters.sobel(im,0,imy)
magnitude = sqrt(imx**2+imy**2)

scipy.misc.imsave('output/twi_sobel_x_python.png', imx)
scipy.misc.imsave('output/twi_sobel_y_python.png', imy)
scipy.misc.imsave('output/twi_sobel_python.png', magnitude)
