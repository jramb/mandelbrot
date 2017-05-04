( Run using "gforth mandel.fs" )
( This program was made by Jörg Ramb, 2015 )

: hello \ --
  ." Hello you!" cr ;

: mypi \ -- f
  355e0 113e0 f/ ;

: mandelzahl \ cx cy max -- dept
  ;

hello

." PI is about " mypi f. cr


4 dup * 5 + .
cr
bye

