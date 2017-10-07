#!/usr/bin/guile \
-e main -s
!#
;; or: -e main -s

;; Mandelbrot set

(define (range l h . step)
  (let ((step (if (null? step) 1 (car step))))
    (let loop ((res '())
               (h (- h step)))
      (if (< h l)
          res
          (loop (cons h res) (- h step))))))

; Stalin does not have complex numbers...
(define real-part car)
(define imag-part cdr)

;; (define c* *)
;; '(define (c* c1 c2)
;;   (let ((r1 (real-part c1))
;;         (i1 (imag-part c1))
;;         (r2 (real-part c2))
;;         (i2 (imag-part c2)))
;;     (cons (- (* r1 r2) (* i1 i2))
;;           (+ (* i1 r2) (* r1 i2)))))

(define make-rectangular cons)

;; '(define c+ +)
;; (define (c+ c1 c2)
;;   (cons (+ (real-part c1) (real-part c2))
;;         (+ (imag-part c1) (imag-part c2))))

;; check if c is still in the set (|c| <= 2)
;; is this version faster
;; (define (unbound? c)
;;   (let ((r (real-part c))
;;         (i (imag-part c)))
;;     (> (+ (* r r) (* i i)) 4)))

;; ;; same, slower (faster in gosh) but more natural?
;; '(define (unbound? c)
;;   (> (magnitude c) 2))


;; ;; test the depth of a complex point (Mandelbrot set)
;; '(define (mandel-test c max)
;;   (let loop ((zi c)
;;              (i 1))
;;       (cond ((> i max) max)
;;           ((unbound? zi) i)
;;           (else (loop (c+ (c* zi zi) c) (+ i 1))))))

(define (mandel-test c max)
  (let ((cx (car c))
        (cy (cdr c)))
    (let loop ((zx 0)
               (zy 0)
               (i 0))
      (let ((zx2 (* zx zx))
            (zy2 (* zy zy)))
        (if (and (<= i max) (< (+ zx2 zy2) 4))
          (loop
            (+ (- zx2 zy2) cx)
            (+ (* zx zy 2) cy)
            (+ i 1))
          i)))))

(define (mandelzahl-to-character i)
  (integer->char
   (+ (remainder i 26)
      (char->integer #\a))))

;; Perform the whole set
(define (mandel width height max)
  (let ((xs (range -2. 1 (/ 3. width)))
        (ys (range -1. 1 (/ 2. height))))
    (for-each
     (lambda (y)
       (for-each
        (lambda (x)
          (let ((m (mandel-test (make-rectangular x y) max)))
            (display (if (< m max)
                         (mandelzahl-to-character m)
                         " "))
                                        ;(display (mandel-test c max))
            ))
        xs)
       (newline))
     ys)))

;(display (format "Hello, ~a\n" *program-name*))
;; for Gambit
(define (main args)
  (if (< (length args) 3)
    (mandel 140 50 10000)
    (let ((width (cadr args))
          (height (caddr args))
          (max (cadddr args)))
      (mandel (string->number width)
              (string->number height)
              (string->number max)))))


;(mandel 140 50 10000)
;; (mandel 70 30 10000)
;; (main "70" "25" "100")
(newline)

;(exit)
