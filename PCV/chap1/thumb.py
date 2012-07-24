# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

from PIL import Image

def make_thumbnail(infile, outfile):
    try:
        im = Image.open(infile)
        im.thumbnail((128,128), getattr(Image, 'ANTIALIAS'))
        im.save(outfile)
    except Exception as ex:
        print(repr(ex))
        print('thumbnail failed %s' % infile)


def main():
    make_thumbnail('twittan2.jpg', 'twittan2_thumb.jpg')


if __name__ == "__main__":
    main()
