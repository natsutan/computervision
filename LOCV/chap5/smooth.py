# -*- coding: utf-8 -*-
from PIL import Image

im = Image.open('../../image/twittan/twittan.jpg')

im.save('twi.jpg')
im.show()

