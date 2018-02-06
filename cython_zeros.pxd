
from newton cimport newton

cdef extern from "zeros.h":
    ctypedef struct default_parameters:
        int funcalls;
        int iterations;
        int error_num;

    ctypedef double (*callback_type)(double,void*)
    ctypedef double (*solver_type)(callback_type, double, double, double, double, int,default_parameters*);

    double bisect(callback_type f, double xa, double xb, double xtol, double rtol, int iter, default_parameters *params);
    double ridder(callback_type f, double xa, double xb, double xtol, double rtol, int iter, default_parameters *params);
    double brenth(callback_type f, double xa, double xb, double xtol, double rtol, int iter, default_parameters *params);
    double brentq(callback_type f, double xa, double xb, double xtol, double rtol, int iter, default_parameters *params);
