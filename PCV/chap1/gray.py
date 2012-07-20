# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

from PIL import Image

def conv_to_grayscale(infile, outfile):
    try:
        Image.open(infile).convert('L').save(outfile)
    except:
        print('cannot convert %s' % infile)


def main():
    conv_to_grayscale('twittan.jpg', 'twittan_pg.jpg')


if __name__ == "__main__":
    main()