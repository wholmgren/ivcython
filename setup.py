from distutils.core import setup
from Cython.Build import cythonize

setup(
    name='ivcython',
    ext_modules=cythonize("*.pyx"),
)
