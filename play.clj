(ns mandelbrot)
(set! *warn-on-reflection* true)

;; Mandelbrot set

;; check if c is still in the set (|c| <= 2)
(defn unbound? [[^Double r ^Double i]]
  (> (+ (* r r) (* i i)) 4))

;; (x + yi)(u + vi) = (xu – yv) + (xv + yu)i.
(defn cplx-mul [[^Double x ^Double y] [^Double u ^Double v]]
  [(- (* x u) (* y v)) (+ (* x v) (* y u))])
;;(cplx-mul [3 4] [-2 9]) ;-> [-42 19]

(defn cplx-add [[^Double r1 ^Double i1] [^Double r2 ^Double i2]]
  [(+ r1 r2) (+ i1 i2)])


;; test the depth of a complex point (Mandelbrot set)
;; 
(defn mandel-test [c max]
  (loop [zi c
         i 1]
    (cond
     (> i max) 0
     (unbound? zi) i
     :else (recur (cplx-add (cplx-mul zi zi) c) (+ i 1)))))

;;(mandel-test [0.5 0.5] 1000) ;-> 5

;; Perform the whole set
(defn mandel [width height max]
  (let [xs (range -2. 1 (/ 3. width))
        ys (range -1. 1 (/ 2. height))]
    (dorun
     (for [y ys]
       (println
        (apply str
             (for [x xs]
               (let [c [x y]]
                 (if (> (mandel-test c max) 0) "-" "*"))
               )))))))

(time (mandelbrot/mandel 140 50 10000))

