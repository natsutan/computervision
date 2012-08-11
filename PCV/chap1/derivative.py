__author__ = 'Natsutani'

from PIL import Image
from numpy import *
import scipy
from scipy.ndimage import filters
im = array(Image.open('box.png').convert('L'))

imx = zeros(im.shape)
filters.sobel(im,1,imx)
imy = zeros(im.shape)
filters.sobel(im,0,imy)
magnitude = sqrt(imx**2+imy**2)

scipy.misc.imsave('sobelx.jpg', imx)
scipy.misc.imsave('sobely.jpg', imy)
scipy.misc.imsave('sobel.jpg', magnitude)


sigma = 1 # standard deviation
imx = zeros(im.shape)
filters.gaussian_filter(im, (sigma,sigma), (0,1), imx)
imy = zeros(im.shape)
filters.gaussian_filter(im, (sigma,sigma), (1,0), imy)

print(imx[40])

magx = imx**2
magy = imy**2
magnitude = sqrt(imx**2+imy**2)

scipy.misc.imsave('twi_gray.png', im)
scipy.misc.imsave('box_dx.png', imx)
scipy.misc.imsave('box_dy.png', imy)
scipy.misc.imsave('box_magx.png', magx)
scipy.misc.imsave('box_magy.png', magy)
scipy.misc.imsave('box_dxdy.png', magnitude)
