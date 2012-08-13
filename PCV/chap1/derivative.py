__author__ = 'Natsutani'

from PIL import Image
from numpy import *
import scipy
from scipy.ndimage import filters
im = array(Image.open('twittan.jpg').convert('L'))

sigma = 1 # standard deviation
imx = zeros(im.shape)
imy = zeros(im.shape)

filters.gaussian_filter(im, (sigma,sigma), (0,1), imx)
filters.gaussian_filter(im, (sigma,sigma), (1,0), imy)

magnitude = sqrt(imx**2+imy**2)

scipy.misc.imsave('output/twi_derivertive_gaussian_x_python.png', imx)
scipy.misc.imsave('output/twi_derivertive_gaussian_y_python.png', imy)
scipy.misc.imsave('output/twi_derivertive_gaussian_python.png', magnitude)
