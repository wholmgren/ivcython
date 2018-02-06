from __future__ import division, print_function, absolute_import

import numpy as np
cimport numpy as np

from libc.math cimport exp

#from scipy.optimize.cython_optimize cimport zeros

# searches for zeros.pxd
cimport zeros

NUM_OF_IRRAD = 100000
IL = np.sin(np.linspace(0, NUM_OF_IRRAD, NUM_OF_IRRAD)) + 6


# governing equations
cdef double f_solarcell(double i, tuple args) :
    cdef double v, il, io, rs, rsh, vt
    v, il, io, rs, rsh, vt = args
    vd = v + i * rs
    return il - io * (exp(vd / vt) - 1.0) - vd / rsh - i


cdef double fprime_no_tuple(double i, double v, double il, double io, double rs, double rsh, double vt):
    return -io * exp((v + i * rs) / vt) * rs / vt - rs / rsh - 1


cdef double fprime(double i, tuple args):
    cdef double v, il, io, rs, rsh, vt
    v, il, io, rs, rsh, vt = args
    return -io * exp((v + i * rs) / vt) * rs / vt - rs / rsh - 1


#solver
cdef double solarcell_newton(tuple args):
    """test newton with array"""
    return zeros.newton(f_solarcell, 6.0, fprime, args)


# cython
def bench_cython_newton(v=5.25, il=IL, args=(1e-09, 0.004, 10, 0.27456)):
    cdef int N = IL.shape[0]
    cdef double[:] out = np.zeros(N)

    for i in range(N):
        out[i] = solarcell_newton((v, il[i],) + args)

    return np.asarray(out)
