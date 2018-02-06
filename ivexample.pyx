from __future__ import division, print_function, absolute_import

import cython
import numpy as np
cimport numpy as np

from libc.math cimport exp

#from scipy.optimize.cython_optimize cimport zeros

# searches for cython_zeros.pxd
cimport cython_zeros
from cython_zeros cimport default_parameters

NUM_OF_IRRAD = 100000
IL = np.sin(np.linspace(0, NUM_OF_IRRAD, NUM_OF_IRRAD)) + 6

# taken from scipy.optimize.zeros
cdef int _iter = 100
cdef double _xtol = 2e-12
cdef double _rtol = 4 * np.finfo(float).eps


# governing equations
@cython.cdivision(True)
cdef double f_solarcell(double i, tuple args) :
    cdef double v, il, io, rs, rsh, vt
    v, il, io, rs, rsh, vt = args
    vd = v + i * rs
    return il - io * (exp(vd / vt) - 1.0) - vd / rsh - i


@cython.cdivision(True)
cdef double fprime_no_tuple(double i, double v, double il, double io, double rs, double rsh, double vt):
    return -io * exp((v + i * rs) / vt) * rs / vt - rs / rsh - 1


@cython.cdivision(True)
cdef double fprime(double i, tuple args):
    cdef double v, il, io, rs, rsh, vt
    v, il, io, rs, rsh, vt = args
    return -io * exp((v + i * rs) / vt) * rs / vt - rs / rsh - 1


#solver
cdef double solarcell_newton(tuple args):
    """test newton with array"""
    return cython_zeros.newton(f_solarcell, 6.0, fprime, args)


# cython
def bench_cython_newton(v=5.25, il=IL, args=(1e-09, 0.004, 10, 0.27456)):
    cdef int N = IL.shape[0]
    cdef double[:] out = np.zeros(N)

    for i in range(N):
        out[i] = solarcell_newton((v, il[i],) + args)

    return np.asarray(out)


# @cython.cdivision(True)
# cdef double f_solarcell_default_parameters(double i, default_parameters *params):
#     cdef double v, il, io, rs, rsh, vt #= *params
#     #v, il, io, rs, rsh, vt = *params
#     vd = v + i * rs
#     return il - io * (exp(vd / vt) - 1.0) - vd / rsh - i
#
#
# #solver
# cdef double solarcell_newton_brentq(default_parameters *params):
#     """test newton with array"""
#     return cython_zeros.brentq(f_solarcell_default_parameters, 0, 10, _xtol, _rtol, _iter, params)
#
#
# # cython
# def bench_cython_newton_brentq(v=5.25, il=IL, args=(1e-09, 0.004, 10, 0.27456)):
#     cdef int N = IL.shape[0]
#     cdef double[:] out = np.zeros(N)
#
#     for i in range(N):
#         default_parameters* params = &np.array([(v, il[i]) + args])
#         out[i] = solarcell_newton_brentq(params)
#
#     return np.asarray(out)
