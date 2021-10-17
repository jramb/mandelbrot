(local width (or (tonumber (and arg (. arg 1))) 140))
(local height (or (tonumber (and arg (. arg 2))) 50))
(local maxd (or (tonumber (and arg (. arg 3))) 100000))
               (fn mandelzahl [cx cy max]
                 (let [(zx zy x2 y2) (values 0 0 0 0)]
                   (var i 0)
                   (while true
                     (set-forcibly! (zy zx)
                                    (values (+ (* (* zx zy) 2) cy)
                                            (+ (- x2 y2) cx)))
                     (set-forcibly! (x2 y2) (values (* zx zx) (* zy zy)))
                     (set i (+ i 1))
                     (when (or (>= i max) (>= (+ x2 y2) 4))
                       (lua :break)))
                   (or (and (< i max) i) (- 1))))
               (fn mandel [w h max]
                 (let [(x y) nil]
                   (for [y -1.0 1.0 (/ 2.0 h)]
                     (local line {})
                     (for [x -2.0 1.0 (/ 3.0 w)]
                       (local mz (mandelzahl x y max))
                       (tset line (+ (length line) 1)
                             (or (and (< mz 0) " ")
                                 (string.char (+ (string.byte :a) (% mz 26))))))
                     (print (table.concat line)))))
(mandel width height maxd)
