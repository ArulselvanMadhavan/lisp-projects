#lang pie

;; (λ (flavor)
;;   (cons flavor 'lentils))

;; ((λ (flavor)
;;   (cons flavor 'lentils)) 'garlic)

(which-Nat 5
           0
           (λ (n)
             n))


(plus 4 2)
(claim gauss
       (-> Nat
           Nat))
(define gauss (n)
  (add1 (gauss (- n 1))))
       
