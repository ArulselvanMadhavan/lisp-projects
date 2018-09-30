#lang pie

(claim kar
       (-> (Pair Nat Nat)
           Nat))
(define kar
  (λ (p)
    3))

(claim swap
       (-> (Pair Nat Atom)
           (Pair Atom Nat)))
(define swap
  (λ (p)
    (cons 'test 4)))

(claim flip
       (Π ((A U)
           (D U))
          (-> (Pair A D)
              (Pair D A))))
(define flip
  (λ (A D)
    (λ (p)
      (cons (cdr p) (car p)))))
