#lang pie

;; (vec:: 'crimini
;;        (vec:: 'shiitake vecnil))

(head (the (Vec Atom 1)
     (vec:: 'test vecnil)))

(the (Vec Atom zero)
     vecnil)

(claim one-list
       (Vec Atom 1))
(define one-list
  (vec:: 'arul
         vecnil))

(claim first-of-one
       (Π ((E U))
          (-> (Vec E 1)
              E)))
(define first-of-one
  (λ (E)
    (λ (es)
      (head es))))

(first-of-one Atom one-list)

(claim three-list
       (Vec Atom 3))
(define three-list
  (vec:: 'selvan
         (vec:: 'test one-list)))

(claim first
       (Π ((E U)
           (l Nat))
          (-> (Vec E (add1 l))
              E)))
(define first
  (λ (E l)
    (λ (es)
      (head es))))

(claim rest
       (Π ((E U)
           (l Nat))
          (-> (Vec E (add1 l))
              (Vec E l))))
(define rest
  (λ (E l)
    (λ (es)
      (tail es))))

(first Atom 2 three-list)
(rest Atom 2 three-list)
