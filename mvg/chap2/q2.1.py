# -*- coding: utf-8 -*-
__author__ = 'Natsutani'

import sys

sys.path.append("../2d_projective_plane/")

import proj2d


def main():
    a = proj2d.point_2d(5, 3)
    b = proj2d.point_2d(11, 5)
    c = proj2d.point_2d(3, 3)
    d = proj2d.point_2d(5, 5)
    l = proj2d.make_line_2d_homo(a,b)
    print(l.to_str())

    print(l.on_the_line(proj2d.make_point_2d_homo(a)))
    print(l.on_the_line(proj2d.make_point_2d_homo(b)))
    print(l.on_the_line(proj2d.make_point_2d_homo(c)))


    lh = proj2d.make_line_2d_homo(a,c)
    print(lh.to_str())

    print(lh.on_the_line(proj2d.make_point_2d_homo(a)))
    print(lh.on_the_line(proj2d.make_point_2d_homo(b)))
    print(lh.on_the_line(proj2d.make_point_2d_homo(c)))

    lv = proj2d.make_line_2d_homo(a,d)
    print(lv.to_str())

    print(lv.on_the_line(proj2d.make_point_2d_homo(a)))
    print(lv.on_the_line(proj2d.make_point_2d_homo(b)))
    print(lv.on_the_line(proj2d.make_point_2d_homo(c)))

    try:
        ln = proj2d.make_line_2d_homo(a,a)
    except ValueError:
        print("Error")


if __name__ == "__main__":
    main()