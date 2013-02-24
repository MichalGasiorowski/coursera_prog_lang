#lang racket

(require "hw4.rkt") 

(require rackunit)

(check-equal? (sequence 3 11 2) (list 3 5 7 9 11) "sequence t1 failed")
(check-equal? (sequence 3 8 3) (list 3 6) "sequence t2 failed")
(check-equal? (sequence 0 5 1) (list 0 1 2 3 4 5) "sequence t3 failed")
(check-equal? (sequence 3 2 1) null "sequence t4 failed")

(check-equal? (string-append-map '("a" "b" "c") "-1")
              '("a-1" "b-1" "c-1") "string-append-map #1" )
(check-equal? (string-append-map '("a") "-1")
              '("a-1") "string-append-map #2" )
(check-equal? (string-append-map null "-1")
              '() "string-append-map #3" )
(define ff (string-append-map 
               (list "dan" "dog" "curry" "dog2") 
               ".jpg"))

(check-equal? (list-nth-mod '("a" "b" "c") 0) 
              "a" "list-nth-mod #1")
(check-equal? (list-nth-mod '("a" "b" "c") 2)
              "c" "list-nth-mod #2")
(check-equal? (list-nth-mod '("a" "b" "c") 4)
              "b" "list-nth-mod #3")

(check-exn (regexp "list-nth-mod: negative number") 
           (lambda () (list-nth-mod '("a" "b" "c") -1) ) "not a 'list-nth-mod: negative number' thrown #5")

(check-exn (regexp "list-nth-mod: empty list") 
           (lambda () (list-nth-mod '() 0)) "not a 'list-nth-mod: empty list' thrown #6")

(define nats-for-test
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(check-equal? (stream-for-n-steps nats-for-test 5)
              '(1 2 3 4 5) "should return 5 elements in list")

(check-equal? (stream-for-n-steps funny-number-stream 16)
              '(1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15 16) "should return 16 numbers")

(check-equal? (stream-for-n-steps funny-number-stream 0)
              '() "should return empty list")

(check-equal? (stream-for-n-steps funny-number-stream 1) 
              '(1) "should return list with 1 element")

(define funny-test (stream-for-n-steps funny-number-stream 16))

(check-equal? (stream-for-n-steps dan-then-dog 4)
              '("dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg") "should return dan.jpg dog.jpg ... of 4 item list")

(check-equal? (stream-for-n-steps dan-then-dog 1)
              '("dan.jpg") "should return dan.jpg item in list")

(check-equal? (stream-for-n-steps dan-then-dog 2)
              '("dan.jpg" "dog.jpg") "should return dan.jpg and dog.jpg items in list")

(check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 2)
              '((0 . "dan.jpg") (0 . "dog.jpg")) "should return 2 pairs (0 . 'dan.jpg') and (0 . 'dog.jpg')")

(check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 4) 
              '((0 . "dan.jpg") (0 . "dog.jpg") (0 . "dan.jpg") (0 . "dog.jpg"))  "should return 4 pairs (0 . 'dan.jpg') and (0 . 'dog.jpg')")

(check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 0) 
              '() "should return empty list")

(check-equal? (stream-for-n-steps (cycle-lists '(1 2 3) '("a" "b") ) 4) 
              '((1 . "a") (2 . "b") (3 . "a") (1 . "b")) "should return mixed lists 4 pairs")

(check-equal? (vector-assoc 5 (list->vector '((1 . "a") (2 . "b") (3 . "c") (4 . "d") (5 . "e")))) 
              (cons 5 "e") "should return pair ( 5 . 'e' )" )

(check-equal? (vector-assoc 6 (list->vector '((1 . "a") (2 . "b") (3 . "c") (4 . "d") (5 . "e")))) 
              #f "should return pair with '5' in field" )

(check-equal? (vector-assoc 5 (list->vector '(1 2 3 4 5))) 
              #f "should return #f for non paired items vector" )

(check-equal? (vector-assoc 7 (list->vector '(1 2 3 4 5 (7 . 8)))) 
              (cons 7 8) "should return pair with '7' in field" )

(check-equal? (vector-assoc 3 (list->vector '(1 2 (3 . 7) 4 5 (7 . 8)))) 
              (cons 3 7) "should return pair with '7' in field" )

(define ctf (cached-assoc '((1 . 2) (3 . 4) (5 . 6) (7 . 8) (9 . 10)) 3 ))

(check-equal? (ctf 3) (cons 3 4) "should return (3 . 4)")
(check-equal? (ctf 5) (cons 5 6) "should return (5 . 6)")
(check-equal? (ctf 9) (cons 9 10) "should return (9 . 10)")
(check-equal? (ctf 11) #f "should return #f for  v=11")

(define a 2)
(while-less 7 do (begin (set! a (+ a 1)) (print "x") a))
(while-less 7 do (begin (set! a (+ a 1)) (print "x") a))
