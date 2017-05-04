#!/usr/bin/env factor-vm
! 2017 by J Ramb
USING: kernel math math.functions math.ranges sequences
    math.complex prettyprint strings io locals 
    combinators formatting
    generalizations ;
IN: mandel

! this does complex numbers!
: iter ( c z -- z' ) dup * + ; inline

: unbound ( c -- ? ) absq 4 > ; inline

:: mz ( c max i z -- n )
  {
    { [ i max >= ] [ -1 ] }
    { [ z unbound ] [ i ] }
    [ c max i 1 + c z iter mz ]
  } cond ; recursive

: mandelzahl ( c max -- n ) 0 0 mz ;

: [a..b] ( step a b -- a..b ) 2dup swap - 4 nrot 1 - / <range> ;

: toChar ( n -- c )
    dup -1 = [ drop 32 ] [ 26 mod CHAR: a + ] if ; inline
    
:: mandel ( w h max -- )
    w h max "%d x %d max=%d\n" printf
    h -1. 1. [a..b]
    [   w -2. 1. [a..b]
        [ dupd swap rect> max mandelzahl toChar ] map
        >string print
        drop ! old h
    ] each
    ;

140 50 10000 mandel

