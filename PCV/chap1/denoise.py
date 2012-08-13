# -*- coding: utf-8 -*-
from numpy import *
from numpy import random
from scipy.ndimage import filters
from scipy.misc import imsave



def denoise(im,U_init,tolerance=0.1,tau=0.125,tv_weight=100):
    """ An implementation of the Rudin-Osher-Fatemi (ROF) denoising model
using the numerical procedure presented in eq (11) A. Chambolle (2005).
Input: noisy input image (grayscale), initial guess for U, weight of
the TV-regularizing term, steplength, tolerance for stop criterion.
Output: denoised and detextured image, texture residual. """
    m,n = im.shape # size of noisy image
    # initialize
    U = U_init
    Px = im # x-component to the dual field
    Py = im # y-component of the dual field
    error = 1
    while (error > tolerance):
        Uold = U
        # gradient of primal variable
        GradUx = roll(U,-1,axis=1)-U # x-component of U's gradient
        GradUy = roll(U,-1,axis=0)-U # y-component of U's gradient
        # update the dual varible
        PxNew = Px + (tau/tv_weight)*GradUx
        PyNew = Py + (tau/tv_weight)*GradUy
        NormNew = maximum(1,sqrt(PxNew**2+PyNew**2))
        Px = PxNew/NormNew # update of x-component (dual)
        Py = PyNew/NormNew # update of y-component (dual)
        # update the primal variable
        RxPx = roll(Px,1,axis=1) # right x-translation of x-component
        RyPy = roll(Py,1,axis=0) # right y-translation of y-component
        DivP = (Px-RxPx)+(Py-RyPy) # divergence of the dual field.
        U = im + tv_weight*DivP # update of the primal variable
        # update of error
        error = linalg.norm(U-Uold)/sqrt(n*m);

    return U,im-U # denoised image and texture residual


im = zeros((500,500))
im[100:400,100:400] = 128
im[200:300,200:300] = 255
im = im + 30*random.standard_normal((500,500))
imsave("synth_ori.jpg", im)
U,T = denoise(im,im)
G = filters.gaussian_filter(im,10)
# save the result
imsave('synth_rof.jpg',U)
imsave('synth_gaussian.jpg',G)
