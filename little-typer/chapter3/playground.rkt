#lang pie

(claim step-+
       (-> Nat
           Nat))
(define step-+
  (λ (+n-1)
    (add1 +n-1)))


(claim +
       (-> Nat Nat
           Nat))
(define +
  (λ (n j)
    (iter-Nat n
              j
              step-+)))

;; Examples
(+ (add1 zero) 7)

;; Gauss
(claim gauss
       (-> Nat
           Nat))
(define gauss
  (λ (n)
    (rec-Nat n
             0
             (λ (n-1 so-far)
               (+ (add1 n-1) so-far)))))

(gauss 3)

;; zero
(claim step-zerop
       (-> Nat Atom
           Atom))
(define step-zerop
  (λ (n-1 zerop)
    'nil))

(claim zerop
       (-> Nat Atom))
(define zerop
  (λ (n)
    (rec-Nat n
             't
             step-zerop)))

;; Examples
(zerop (add1 zero))
(zerop zero)

;; Multiplication

(claim make-step-*
       (-> Nat
           (-> Nat Nat
               Nat)))
(define make-step-*
  (λ (j)
    (λ (n-1 so-far)
      (+ j so-far))))

(claim *
       (-> Nat Nat
           Nat))
(define *
  (λ (n j)
    (rec-Nat n
             0
             (make-step-* j))))

;; Examples
(* 9 0)
