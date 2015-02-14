# Mandelbrot

## A collection of implementations of the Mandelbrot algorithm

This is a collection of programs in different languages and dialects to implement a command-line
version of a program to display the Mandelbrot set.

Basically the test case is to display a 140 x 50 (extra points if that is controllable as a parameter)
area of -2 to 1 (real part) and -1 to 1 (imaginary part) of the Mandelbrot set. Most programs display a "-"
if the corresponding point is not in the Mandelbrot set, a "*" if it is. The depth is also ususally a parameter,
for example 1000 or 10000, or hardcoded into the program.

The result looks like this (smaller version):

    ------------------------------------------------------------
    ------------------------------------****--------------------
    ------------------------------------****--------------------
    ------------------------------*--**********-----------------
    ------------------------------*****************-------------
    ----------------------------*******************-------------
    ---------------------------*********************------------
    -----------------*******--**********************------------
    ----------------*********-**********************------------
    **********************************************--------------
    ----------------*********-**********************------------
    -----------------*******--**********************------------
    ---------------------------*********************------------
    ----------------------------*******************-------------
    ------------------------------*****************-------------
    -----------------------------*--**********-----------------
    ------------------------------------****--------------------
    ------------------------------------****--------------------
    ------------------------------------------------------------
    ----------------------------------------*-------------------

## Why this?

1. For fun
2. I use it to get a first impresssion of languages and their performance and (mostly) aestetic to perform
some not too simple but not too complex task, that also has some appeal, even if you do not care about the mathematics.
3. It is not meant as a "shoot-out" between languages, nor does it compete with Rosetta code or similar.
  For each language I tried to produce a version that is what I think idiomatic code, not necessarily speed optimized.

You are allowed to use this code in any production system, without any warranty from my side. If Mars landers
krash because of this, don't come to me, crying.

## History
This used to be a gist, but it has grown a bit, so I am moving it to a real repository.

