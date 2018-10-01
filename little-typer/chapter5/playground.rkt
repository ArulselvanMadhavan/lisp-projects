#lang pie

(claim rugbrod
       (List Atom))
(define rugbrod
  (:: 'rye-floar
      (:: 'rye-kernel
          (:: 'water
              (:: 'sourdough
                  (:: 'salt nil))))))

(claim toppings
       (List Atom))
(define toppings
  (:: 'potato
      (:: 'butter nil)))

(claim condiments
       (List Atom))
(define condiments
  (:: 'chives
      (:: 'mayonnaise nil)))

(claim step-length
       (Π ((E U))
          (-> E (List E) Nat Nat)))
(define step-length
  (λ (E)
    (λ (e es length-1)
      (add1 length-1))))

(claim length
       (Π ((E U))
          (-> (List E) Nat)))
(define length
  (λ (E)
    (λ (es)
      (rec-List es
                0
                (step-length E)))))

(claim step-append
       (Π ((E U))
          (-> E (List E) (List E)
              (List E))))
(define step-append
  (λ (E)
    (λ (e es append-es)
      (:: e append-es))))

(claim append
       (Π ((E U))
          (-> (List E) (List E)
              (List E))))
(define append
  (λ (E)
    (λ (xs ys)
      (rec-List xs
                ys
                (step-append E)))))
