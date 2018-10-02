#lang pie

(claim mot-peas
       (-> Nat
           U))
(define mot-peas
  (λ (k)
    (Vec Atom k)))

(claim base-peas
       (Vec Atom 0))
(define base-peas
  vecnil)

(claim step-peas
       (Π ((l-1 Nat))
          (-> (mot-peas l-1)
              (mot-peas (add1 l-1)))))
(define step-peas
  (λ (l-1)
    (λ (almost-peas)
      (vec:: 'pea almost-peas))))

(claim peas
       (Π ((l Nat))
          (Vec Atom l)))
(define peas
  (λ (l)
    (ind-Nat l
             mot-peas
             vecnil
             step-peas)))

(claim also-rec-Nat
       (Π ((X U))
          (-> Nat
              X
              (-> Nat X
                  X)
              X)))
(define also-rec-Nat
  (λ (X)
    (λ (target base step)
      (ind-Nat target
               (λ (k)
                 X)
               base
               step))))

(claim base-last
       (Π ((E U))
          (-> (Vec E (add1 zero))
              E)))
(define base-last
  (λ (E)
    (λ (es)
      (head es))))

(claim last
       (Π ((E U)
           (l Nat))
          (-> (Vec E (add1 l))
              E)))
(define last
  (λ (E)
    (λ (l)
      (ind-Nat l
               ))))
