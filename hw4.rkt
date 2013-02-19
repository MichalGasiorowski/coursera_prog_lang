#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (stream-maker fn arg)
  (letrec ([f (lambda (x)
                (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f arg))))

;; 1

(define (sequence low high stride)
  (if (> low high)
      empty
      (cons low (sequence (+ low stride) high stride))))

;; 2
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

;; 3

(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))])) 

;; 4
(define (stream-for-n-steps s n)
  (if (<= n 0)
      empty
      (let ([pr (s)])
        (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1))))))

;; 5
(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= (remainder x 5) 0)
                                (- x)
                                x) (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;; 6
(define dan-then-dog
    (letrec ([f (lambda (t) (cons (if t 
                                      "dan.jpg" 
                                      "dog.jpg") (lambda () (f (not t)))))])
      (lambda () (f #t))))

;; 7
(define (stream-add-zero s)
  (let ([pr (s)])
    (lambda () (cons (cons 0 (car pr)) (stream-add-zero (cdr pr))))))

;; 8 (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))

(define (cycle-lists xs ys)
  (define (helper n)
    (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda () (helper (+ n 1)))))
  (lambda () (helper 0)))

;; 9
(define (vector-assoc v vec)
  (define (helper n)
    (cond 
      [(>= n (vector-length vec)) #f]
      [(not (pair? (vector-ref vec n))) (helper (+ n 1))]
      [#t (let ([p (vector-ref vec n)])
            (if (equal? (car p) v) p (helper (+ n 1))))]))
  (helper 0))

;; 10

  

  
    
