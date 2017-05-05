#!/usr/bin/env factor-vm
! 2017 by J Ramb
USING: kernel math math.functions math.ranges sequences
    math.complex prettyprint strings io locals
    combinators formatting generalizations ;
IN: mandel

! "[a..b]" returns a lazy sequence.
! with ("::") or without (":") generalizations:
! : [a..b] ( steps a b -- a..b ) 2dup swap - 4 nrot 1 - / <range> ;
::  [a..b] ( steps a b -- a..b ) a b b a - steps 1 - / <range> ;

! converts a number to a character:
: >char ( n -- c )
    dup -1 = [ drop 32 ] [ 26 mod CHAR: a + ] if ;

! iterates z' = z^2 + c, Factor does complex numbers!
: iter ( c z -- z' ) dup * + ;

! absq is the square of the abs (of a complex)
: unbound ( c -- ? ) absq 4 > ;

! tail-recursive helper
:: mz ( c max i z -- n )
  {
    { [ i max >= ] [ -1 ] }
    { [ z unbound ] [ i ] }
    [ c max i 1 + c z iter mz ]
  } cond ;

: mandelzahl ( c max -- n ) 0 0 mz ;

:: mandel ( w h max -- )
    w h max "%d x %d max=%d\n" printf
    h -1. 1. [a..b] ! range over y
    [   w -2. 1. [a..b] ! range over x
        [ dupd swap rect> max mandelzahl >char ] map
        >string print
        drop ! old y
    ] each
    ;

! MAIN:
140 50 10000 mandel

! 2.77 s on Intel i7-930 @ 2.8 GHz (4 core)

