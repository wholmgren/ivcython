from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

import numpy as np

setup(
    name='ivcython',
    ext_modules=cythonize("*.pyx"),
    include_dirs=[np.get_include()]
)
