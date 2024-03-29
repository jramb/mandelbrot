#!/usr/bin/env fennel
; 2021-10-17 J Ramb

(fn mandelzahl [cr ci max i tr ti tr2 ti2]
  "Calculates the Mandelbrot escape number of a complex point c"
  (if (>= i max)         -1
      (>= (+ tr2 ti2) 4)  i
      (let [(tr ti) (values (+ (- tr2 ti2) cr)
                            (+ (* tr ti 2) ci))]
        (mandelzahl cr ci max (+ i 1)
                    tr ti (* tr tr) (* ti ti)))))

(fn mandel [w h max]
  "Entry point, generate a 'graphical' representation of the Mandelbrot set"
  (for [y -1.0 1.0 (/ 2.0 h)]
    (var line {})
    (for [x -2.0 1.0 (/ 3.0 w)]
      (let [mz (mandelzahl x y max 0 0 0 0 0)]
        (tset line (+ (length line) 1)
              (or (and (< mz 0) " ")
                  (string.char (+ (string.byte :a) (% mz 26)))))))
    (print (table.concat line))))

(fn arg-def [pos default]
  "A helper fn to extract command line parameter with defaults" 
  (or (tonumber (and arg (. arg pos))) default))

(let [width  (arg-def 1 140)
      height (arg-def 2 50)
      max    (arg-def 3 1e5)]
  (mandel width height max))
