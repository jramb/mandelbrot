(ns mandel.core)
;; 2018 for Clojurescript Jörg Ramb

;; (println "Hello world!")

;; (set! *warn-on-reflection* true)
;(set! *unchecked-math* true)
;; (set! *unchecked-math* :warn-on-boxed)

;; Mandelbrot set

;; check if c is outside the set (|c| > 2)
(defn unbound? [^double r ^double i]
  (> (+ (* r r) (* i i)) 4.))

;; test the depth of a complex point (Mandelbrot set)
(defn mandel-test [cr ci ^long max]
  (loop [zir 0.0
         zii 0.0
         i 1]
    (cond
     (> i max) 0
     (unbound? zir zii) i
     :else (recur (+ (* zir zir) (- (* zii zii)) cr)
                  (+ (* zir zii 2.0) ci)
                  (inc i)))))

;;(mandel-test 0.5 0.5 1000) ;-> 5

(def char_a (int (.charCodeAt \a 0)))

(defn >char [^long n]
  (if (> n 0)
    (char (+ char_a -1 ^long (mod n 26)))
    " "))

;; Perform the whole set
(defn mandel [^long width ^long height ^long max]
  (let [xs (range -2. 1 (/ 3. width))
        ys (range -1. 1 (/ 2. height))
        calc-line (fn [y]
                    (apply str
                     (for [x xs]
                       (>char (mandel-test x y max)))))]
        (dorun
          (map println
            ; here: pmap = parallel version, map would be serial
           (map calc-line ys)))))


(defn -main [& args]
  (let [[w h max] (map #?(:clj read-string :cljs js/parseInt) args)
        w (or w 140)
        h (or h 50)
        max (or max 1e5)]
    (time (mandel w h max)))
  #_(System/exit 0))

#_(time (mandel 140 50 1e5))
#?(:cljs (-main))
