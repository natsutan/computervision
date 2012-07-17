# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

import sys

sys.path.append("../2d_projective_plane/")

import proj2d


def main():
    a = proj2d.point_2d(5, 3)
    b = proj2d.point_2d(11, 5)
    l = proj2d.make_line_2d_homo(a,b)
    print(l.to_str())


if __name__ == "__main__":
    main()