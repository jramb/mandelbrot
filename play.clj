(ns mandelbrot)

(defn real-part [c]
  (get c 0))

(defn imag-part [c]
  (get c 1))

;; Mandelbrot set

;; check if c is still in the set (|c| <= 2)
;; is this version faster
(defn unbound? [c]
  (let [r (real-part c)
        i (imag-part c)]
    (> (+ (* r r) (* i i)) 4)))

;; (x + yi)(u + vi) = (xu – yv) + (xv + yu)i.
(defn cplx-mul [[x y] [u v]]
  [(- (* x u) (* y v)) (+ (* x v) (* y u))])
;;(cplx-mul [3 4] [-2 9]) ;-> [-42 19]

(defn cplx-add [[r1 i1] [r2 i2]]
  [(+ r1 r2) (+ i1 i2)])

(defn make-rectangular [r i]
  [r i])

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
               (let [c (make-rectangular x y)]
                 (if (> (mandel-test c max) 0) "-" "*"))
               )))))))

(time (mandel 70 30 10000))

