;; Basic debugging
(define (println x)
  (display x)
  (newline)
  x)

;; Chapter 1 helpers
(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

;; Chapter 2 - Data structures
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

;; Chapter 2 - Graphics (MIT Scheme specific)
;; These work if you have MIT Scheme's graphics
(define (draw-line start end)
  (let ((x1 (x-point start))
        (y1 (y-point start))
        (x2 (x-point end))
        (y2 (y-point end)))
    (graphics-draw-line x1 y1 x2 y2)))

;; Timing utilities
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;; Enable graphics (if available)
;; (graphics-enable-buffering #f)
;; (define graphics-device (make-graphics-device 'x11 500 500))