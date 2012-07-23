# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

import os
from matplotlib.pyplot import *

def scatter_plot(x,y):
    title('exercise 2.1')
    scatter(x,y)
    [xmin, xmax, ymin, ymax] = axis() #今の境界を返す
    axis([xmin-3.0,xmax+2.0,ymin-3.0,ymax+2.0]) #新しい境界を設定
    grid(True) # gridを入れる。

    # 座標軸
    axvline(x=0)
    axvline(linewidth=1, color='b')
    axhline(y=0)
    axhline(linewidth=1, color='b')

    show()


def main():
    # 環境変数の設定
    os.environ['TCL_LIBRARY'] = 'C:/Python32/tcl/tcl8.5'
    os.environ['TK_LIBRARY'] = 'C:/Python32/tcl/tk8.5'

    x = (5,11,3,5)
    y = (3,5,3,5)

    scatter_plot(x,y)

if __name__ == "__main__":
    main()

