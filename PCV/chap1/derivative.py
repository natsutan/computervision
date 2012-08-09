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

scipy.misc.imsave('sobelx.jpg', imx)
scipy.misc.imsave('sobely.jpg', imy)
scipy.misc.imsave('sobel.jpg', magnitude)


sigma = 5 # standard deviation
imx = zeros(im.shape)
filters.gaussian_filter(im, (sigma,sigma), (0,1), imx)
imy = zeros(im.shape)
filters.gaussian_filter(im, (sigma,sigma), (1,0), imy)
magnitude = sqrt(imx**2+imy**2)

scipy.misc.imsave('gdfx.jpg', imx)
scipy.misc.imsave('gdfy.jpg', imy)
scipy.misc.imsave('gdf.jpg', magnitude)
