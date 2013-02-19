; Programming Languages, Dan Grossman, Jan-March 2013
; Section 5: Racket Definitions, Functions, Conditionals

#lang racket

(provide (all-defined-out))

(define a 3)
(define b (+ a 2))

(define cube1
  (lambda (x)
    (* x (* x x))))

(define cube2
  (lambda (x)
    (* x x x)))

(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (append (cdr xs) ys))))

(define (mod x)
  (cond [(> x 0) x]
        [#t (- x)]))


