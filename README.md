ivcython
========

Hacking around with cython for photovoltaic current and voltage calculations.

To compile, you'll need to run

```
python setup.py build_ext --inplace
```

You'll need numpy and cython.

License for my code is MIT (though I started from @mikofski's code, so...). Should add this.

The bisect, brenth, brentq, and ridder code is from scipy and distributed under BSD 3. Should add this.

See https://github.com/scipy/scipy/issues/8354