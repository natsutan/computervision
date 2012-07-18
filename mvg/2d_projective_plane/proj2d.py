# -*- coding: utf-8 -*-

DELTA = 0.0001

class point_2d:
    def __init__(self, x, y):
        self.x = float(x)
        self.y = float(y)

class point_2d_homo:
    def __init__(self, x, y, w):
        self.x = float(x)
        self.y = float(y)
        self.w = float(w)

# ax + by + c = 0
class line_2d_homo:
    def __init__(self, a, b, c):
        self.a = float(a)
        self.b = float(b)
        self.c = float(c)

    def to_str(self):
        return '%f x + %f y + %f = 0 ' % (self.a, self.b, self.c)

    def on_the_line(self, p_2dh, d = DELTA):
        inner_product = p_2dh.x * self.a + p_2dh.y * self.b + p_2dh.w * self.c
        if abs(inner_product) < d:
            return True
        else:
            return False

def make_line_2d_homo(p0, p1):
    '''2点 p0, p1 から同次表現の直線を作る'''
    if p0 == p1:
        raise ValueError('P0 と P1 が同じ座標です')

    if p0.x == p1.x:
        c = -p0.x
        return line_2d_homo(1, 0, c)

    if p0.y == p1.y:
        c = -p0.y
        return line_2d_homo(0, 1, c)

    c = 1.0
    slope = (p1.y - p0.y) / (p1.x - p0.x)

    a = -1 / (p0.x - (p0.y / slope))
    b = -1 / (p0.y - (p0.x * slope))
    return line_2d_homo(a, b, c)

def make_point_2d_homo(p):
    '''点pから、同次表現の点を作る'''
    return point_2d_homo(p.x, p.y, 1.0)


