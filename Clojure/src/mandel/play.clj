(ns mandel.play
  (:gen-class))

; Jörg Ramb
(set! *warn-on-reflection* true)
;(set! *unchecked-math* true)
(set! *unchecked-math* :warn-on-boxed)

;; Mandelbrot set

;; check if c is outside the set (|c| > 2)
(defn unbound? [[^double r ^double i]]
  (> (+ (* r r) (* i i)) 4.))

; this is an incorrect check, which distorts the colors
;(defn unbound? [[^double r ^double i]]
  ;(or (> r 2) (< r -2) (> i 2) (< i -2)))

;; (x + yi)(u + vi) = (xu – yv) + (xv + yu)i.
(defn cplx-mul [[^double x ^double y] [^double u ^double v]]
  [(- (* x u) (* y v)) (+ (* x v) (* y u))])
;;(cplx-mul [3 4] [-2 9]) ;-> [-42 19]

(defn cplx-add [[^double r1 ^double i1] [^double r2 ^double i2]]
  [(+ r1 r2) (+ i1 i2)])

;; z*z + c, slightly faster than (cplx-add (cplx-mul z z) c)
(defn iter [[^double zr ^double zi] [^double cr ^double ci]]
  [(+ (* zr zr) (- (* zi zi)) cr)
   (+ (* zr zi 2.0) ci)])

;; test the depth of a complex point (Mandelbrot set)
;;
(defn mandel-test [c ^long max]
  (loop [zi [0.0 0.0] ;; c
         i 1]
    (cond
     (> i max) 0
     (unbound? zi) i
     :else (recur (iter zi c) (inc i)))))

;;(mandel-test [0.5 0.5] 1000) ;-> 5

(defn >char [^long n]
  (if (> n 0)
    (char (+ (long \a) ^long (mod n 26)))
    " "))

;; Perform the whole set
(defn mandel [^long width ^long height ^long max]
  (let [xs (range -2. 1 (/ 3. width))
        ys (range -1. 1 (/ 2. height))
        calc-line (fn [y]
                    (apply str
                     (for [x xs]
                       (>char (mandel-test [x y] max)))))]
        (dorun
          (map println
            ; here: pmap = parallel version, map would be serial
           (pmap #(calc-line %) ys)))))

(defn -main [& args]
  (time (mandel 140 50 1e4))
  (System/exit 0))

(comment

  (time (mandel 140 50 1e4))
  )

