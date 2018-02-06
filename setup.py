from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

import numpy as np

extensions = []

# newton_zero
extensions.append(
    Extension("newton", ["newton.pyx"],
        include_dirs=[np.get_include()]
    )
)

# cython_zeros
extensions.append(
    Extension("cython_zeros", ["cython_zeros.pyx"],
        include_dirs=[np.get_include()]
    )
)

# ivexample
extensions.append(
    Extension("ivexample", ["ivexample.pyx"],
        include_dirs=[np.get_include()]
    )
)

# scipy Zeros
# build rootfind library
# extensions.append(
#     Extension("rootfind"))

# cython_zeros
#cython_zeros_src = ['newton.pyx']

setup(
    name='ivcython',
    ext_modules=cythonize(extensions),
    include_dirs=[np.get_include()]
)
