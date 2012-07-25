# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

from PIL import Image

def make_thumbnail(infile, outfile):
    try:
        im = Image.open(infile)
        box = (10,300,120,450)
        # コピー
        region = im.crop(box)
        # 回転
        region = region.transpose(Image.ROTATE_180)
        # ペースト
        im.paste(region,box)
        im.save(outfile)
    except Exception as ex:
        print(repr(ex))
        print('copy and paste failed %s' % infile)


def main():
    make_thumbnail('twittan.jpg', 'twittan_cc.jpg')


if __name__ == "__main__":
    main()
