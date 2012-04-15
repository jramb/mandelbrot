#!/usr/bin/gsi-script -:d0
!#

;; compile:
;; gsc -link play.scm && gcc -L$GAMBIT_DIR/lib -I$GAMBIT_DIR/include play.c play_.c -lgambc -lm -ldl -lutil -o play
;; call with:
;; ./play 70 30 10000


(define (dec n)  (- n 1))
(define (inc n)  (+ n 1))

(define (range l h . step)
  (let ((step (if (null? step) 1 (car step))))
    (let loop ((res '())
               (h (- h step)))
      (if (< h l)
          res
          (loop (cons h res) (- h step))))))

;; same?
(define (reverse1 ls)
  (define (rv ls acc)
    (if (null? ls)
        acc
        (rv (cdr ls) (cons (car ls) acc))))
  (rv ls '()))


(define (reverse ls)
  (let rv ((ls ls)
           (acc '()))
    (if (null? ls)
        acc
        (rv (cdr ls) (cons (car ls) acc)))))


(define (take n lst)
  (let loop ((res '())
             (n n)
             (lst lst))
    (if (<= n 0)
        (reverse res)
        (loop (cons (car lst) res) (dec n) (cdr lst)))))

(define (drop n lst)
  (if (< n 1)
      lst
      (drop (dec n) (cdr lst))))

(define (nth lst n)
  (car (drop n lst)))
  

;; Mandelbrot set

;; check if c is still in the set (|c| <= 2)
;; is this version faster
(define (unbound? c)
  (let ((r (real-part c))
        (i (imag-part c)))
    (> (+ (* r r) (* i i)) 4)))

;; same, slower but more natural?
(define (unbound2? c)
  (> (magnitude c) 2))


;; test the depth of a complex point (Mandelbrot set)
;; 
(define (mandel-test c max)
  (let loop ((zi c)
             (i 1))
      (cond ((> i max) 0)
          ((unbound? zi) i)
          (else (loop (+ (* zi zi) c) (+ i 1))))))

;; Perform the whole set
(define (mandel width height max)
  (let ((xs (range -2. 1 (/ 3. width)))
        (ys (range -1. 1 (/ 2. height))))
    (for-each
     (lambda (y)
       (for-each
        (lambda (x)
          (let ((c (make-rectangular x y)))
            (display (if (> (mandel-test c max) 0) "-" "*"))))
        xs)
       (newline))
     ys)))


;; for Gambit
(define (main width height max)
  (mandel (string->number width)
          (string->number height)
          (string->number max)))

;; (mandel 70 25 100)
;; (main "70" "25" "100")