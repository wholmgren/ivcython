
ctypedef double (*callback_type_tup)(double, tuple);

cdef double newton(callback_type_tup func, double x0, callback_type_tup fprime, tuple args)
