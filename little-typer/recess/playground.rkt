#lang pie

(claim peas
       TODO)

(claim peas1
       (Π ((n Nat))
          TODO))

(claim peas2
       (Π ((n Nat))
          (Vec Atom n)))
(define peas2
  (λ (n)
    (ind-Nat n
             (λ (k)
               (Vec Atom k))
             vecnil
             (λ (n-1 peas-n-1)
               (vec:: 'pea peas-n-1)))))
