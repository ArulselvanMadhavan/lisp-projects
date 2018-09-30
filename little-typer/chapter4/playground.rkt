#lang pie

(claim flip
       (Π ((A U)
           (D U))
          (-> (Pair A D)
              (Pair D A))))
(define flip
  (λ (A D)
    (λ (p)
      (cons (cdr p) (car p)))))

(claim elim-pair
       (Π ((A U)
           (D U)
           (X U))
          (-> (Pair A D)
              (-> A D
                  X)
              X)))
(define elim-pair
  (λ (A D X)
    (λ (p f)
      (f (car p) (cdr p)))))

(claim kar
       (-> (Pair Nat Nat)
           Nat))
(define kar
  (λ (p)
    (elim-pair Nat Nat
               Nat
               p
               (λ (a d)
                 a))))

(claim kdr
       (-> (Pair Nat Nat)
           Nat))
(define kdr
  (λ (p)
    (elim-pair Nat Nat
               Nat
               p
               (λ (a d)
                 d))))

(claim swap
       (-> (Pair Nat Atom)
           (Pair Atom Nat)))
(define swap
  (λ (p)
    (elim-pair Nat Atom
               (Pair Atom Nat)
               p
               (λ (a d)
                 (cons d a)))))

(claim twin
       (Π ((A U))
          (-> A
              (Pair A A))))
(define twin
  (λ (A)
    (λ (a)
      (cons a a))))
