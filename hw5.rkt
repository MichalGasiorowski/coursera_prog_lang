;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;; CHANGE (put your solutions here)
(define (racketlist->mupllist es)
  (if (null? es)
      (aunit)
      (apair (car es) (racketlist->mupllist (cdr es)))))
 
(define (mupllist->racketlist e)
  (if (aunit? e)
      (list)
      (if (apair? e)
          (cons (apair-e1 e) (mupllist->racketlist (apair-e2 e)))
          (error "syntax error"))))

;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; CHANGE add more cases here
        [(int? e)
         (int (int-num e))]
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) 
                    (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater applied to non-numbers")))]
        [(fst? e)
         (let ([p (eval-under-env (fst-e e) env)])
           (if (apair? p)
               (apair-e1 p)
               (error "MUPL fst applied to non-pair")))]
        [(snd? e)
         (let ([p (eval-under-env (snd-e e) env)])
           (if (apair? p)
               (apair-e2 p)
               (error "MUPL snd applied to non-pair")))]
        [(apair? e)
         (let ([v1 (eval-under-env (apair-e1 e) env)]
               [v2 (eval-under-env (apair-e2 e) env)])
           (apair v1 v2))]
        [(aunit? e)
         (aunit)]
        [(isaunit? e)
         (if (equal? (eval-under-env (isaunit-e e) env) (aunit))
             (int 1)
             (int 0))]
        [(fun? e) ;(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
         (if (and (or (string? (fun-nameopt e)) (not (fun-nameopt e))) 
                  (string? (fun-formal e))) 
             ;(closure env e)
             (closure env e)
             (error "MUPL fun bad syntax"))]
        [(closure? e) ;(struct closure (env fun) #:transparent) 
         ;(closure (closure-env e) (closure-fun e))]
         e]
        [(mlet? e) ;(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body)
         (let ([v (mlet-var e)])
           (if (string? v)
             (let ([val (eval-under-env (mlet-e e) env)])
               (eval-under-env (mlet-body e) (if (null? env)
                                                 (list (cons v val))
                                                 (cons (cons v val) env))))
             (error "MUPL mlet expression error: var is not a string")))]
        [(call? e)  ;(struct call (funexp actual)       #:transparent) ;; function call       
         (let* ([sub1 (eval-under-env (call-funexp e) env)]
               [sub2 (eval-under-env (call-actual e) env)]
               [issub1fun (fun? sub1)]
               [issub1closure (closure? sub1)])    
           (if (or #f issub1closure)
               (let* ([f (if issub1fun sub1 (closure-fun sub1))] 
                      [fenv (if issub1fun env (closure-env sub1))]
                      [fname (fun-nameopt f)]
                      [fformal (fun-formal f)]
                      [fbody (fun-body f)]
                      [env2 (if (not fname)
                                (if (null? fenv)
                                    (list (cons fformal sub2))
                                    (cons (cons fformal sub2) fenv))
                                (if (null? fenv)
                                    (list (cons fformal sub2) (cons fname f))
                                    (cons (list (cons fformal sub2) (cons fname f)) fenv)))])
                 (eval-under-env fbody env2))
                      (error "MUPL call error, not a closure")))]
                      
               
         
        [#t (error "bad MUPL expression")]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3) 
  (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2) 
  (if (null? lstlst) 
      e2
      (mlet (car (car lstlst)) (cdr (car lstlst)) (mlet* (cdr lstlst) e2)))) 

(define (ifeq e1 e2 e3 e4) 
  (mlet "_x" e1 
        (mlet "_y" e2 
              (ifgreater (var "_x") (var "_y") 
              (ifgreater (var "_y") (var "_x") e3 e4) (ifgreater (var "_y") (var "_x" e4 e3))))))  
     

;; Problem 4
 ;(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(define mupl-map 
  (fun #f "m_f" 
       (fun "rec" "lst" (ifaunit (var "lst") (aunit) 
                                 (apair (snd (var "lst")) (call (var "rec") (call (var "m_f") (fst (var "lst"))))))))) 

(define mupl-mapAddN 
  (mlet "map" mupl-map
        "CHANGE (notice map is now in MUPL scope)"))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))



