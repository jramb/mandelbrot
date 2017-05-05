#!/usr/bin/env factor-vm
! 2017 by J Ramb
USING: kernel math math.functions math.ranges sequences
    math.complex prettyprint strings io locals
    combinators formatting generalizations ;
IN: mandel

! : [a..b] ( step a b -- a..b ) 2dup swap - 4 nrot 1 - / <range> ;
::  [a..b] ( step a b -- a..b ) a b b a - step 1 - / <range> ;

: >char ( n -- c )
    dup -1 = [ drop 32 ] [ 26 mod CHAR: a + ] if ;

! this does complex numbers!
: iter ( c z -- z' ) dup * + ;

: unbound ( c -- ? ) absq 4 > ;

:: mz ( c max i z -- n )
  {
    { [ i max >= ] [ -1 ] }
    { [ z unbound ] [ i ] }
    [ c max i 1 + c z iter mz ]
  } cond ;

: mandelzahl ( c max -- n ) 0 0 mz ;

:: mandel ( w h max -- )
    w h max "%d x %d max=%d\n" printf
    h -1. 1. [a..b]
    [   w -2. 1. [a..b]
        [ dupd swap rect> max mandelzahl >char ] map
        >string print
        drop ! old h
    ] each
    ;

140 50 10000 mandel

