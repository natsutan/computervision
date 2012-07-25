# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

import sys
import os
from matplotlib.pyplot import *

class plot_data():
    def __init__(self):
        self.x = []
        self.y = []
        self.text = []
        self.title = ''
        self.output = ''

    def read_file(self, fname):
        fp = open(fname, 'r')
        buf = fp.readline()
        while(buf.rstrip() != '[data]'):
            palam_s, value_s = buf.split('=')
            palam = palam_s.strip().lower()
            value = value_s.strip()

            if palam == 'title':
                self.title = value
            if palam == 'output':
                self.output = value
            buf = fp.readline()

        buf = fp.readline()
        while buf:
            x, y, text = buf.split(',')
            self.x.append(float(x))
            self.y.append(float(y))
            self.text.append(text)
            buf = fp.readline()

    def xmax(self):
        return max(self.x)

    def xmin(self):
        return min(self.x)

    def ymax(self):
        return max(self.y)

    def ymin(self):
        return min(self.y)

def plot_scatter(data):
    title(data.title)
    scatter(data.x, data.y)
    xmax = data.xmax() <


    xmin = data.xmin()
    ymax = data.ymax()
    ymin = data.ymin()

    axis([-2.0,xmax+2.0,-2.0,ymax+2.0]) #新しい境界を設定
    grid(True) # gridを入れる。

    # 座標軸
    axvline(x=0)
    axvline(linewidth=1, color='b')
    axhline(y=0)
    axhline(linewidth=1, color='b')
    xlabel("x")
    ylabel("y")

    # テキスト
    annotate('A', (5, 3), xytext=(5.0, 1), textcoords='offset points')

    show()


def main(infile):
    pdata = plot_data()
    pdata.read_file(infile)
    plot_scatter(pdata)

def usage():
    print("python scatter.py infile")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        usage()
        # 環境変数の設定
    os.environ['TCL_LIBRARY'] = 'C:/Python32/tcl/tcl8.5'
    os.environ['TK_LIBRARY'] = 'C:/Python32/tcl/tk8.5'

    main(sys.argv[1])
