# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

import sys

sys.path.append("../2d_projective_plane/")

import proj2d


def main():
    a = proj2d.point_2d(5, 3)
    b = proj2d.point_2d(11, 5)
    c = proj2d.point_2d(3, 3)
    l = proj2d.make_line_2d_homo(a,b)
    print(l.to_str())

    a_h = proj2d.make_point_2d_homo(a)
    b_h = proj2d.make_point_2d_homo(b)
    c_h = proj2d.make_point_2d_homo(c)

    print(l.on_the_line(a_h))
    print(l.on_the_line(b_h))
    print(l.on_the_line(c_h))


if __name__ == "__main__":
    main()