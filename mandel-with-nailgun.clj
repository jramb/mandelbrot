(ns nail.core
  (:import
    [java.io BufferedReader ByteArrayOutputStream InputStreamReader
     OutputStreamWriter PrintStream PrintWriter]
    clojure.lang.LineNumberingPushbackReader
    [com.martiansoftware.nailgun NGContext NGServer])
  (:gen-class) ;; needed for the -main below
  )

;;;;;;;;;;;;
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
;;;;;;;;;;;;



(gen-class :name nailgun.Mandel
           :prefix "Mandel-"
           :methods [#^{:static true}
                     [nailMain [com.martiansoftware.nailgun.NGContext] void]]
           :main false)

(defn Mandel-nailMain
  [#^NGContext context]
  (let [ctx (bean context)]
    (binding [*in*  (-> context
                        .in
                        InputStreamReader.
                        LineNumberingPushbackReader.)
              *out* (-> context .out OutputStreamWriter.)
              *err* (-> context .err PrintWriter.)]
      ;;(println "Hej: " (bean context))
      (println "Args: " (seq (:args ctx)))
      (println "Command: " (:command ctx))
      (println "Env (only 2):" (take 2 (:env ctx)))
      (println "Inet addr: " (:inetAddress ctx))
      (println "Current working directory: " (:workingDirectory ctx))
      (apply mandel (map #(Integer. %) (:args ctx)))
      (.flush *out*)
      (.flush *err*))))

(defn -main [& args]
  (println "Starting NGServer!")
  (.start (Thread. (NGServer.))))