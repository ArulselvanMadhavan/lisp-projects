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

(claim snoc
       (Π ((E U))
          (-> (List E) E
              (List E))))
(define snoc
  (λ (E)
    (λ (start e)
      (rec-List start
                (:: e nil)
                (step-append E)))))

(claim iter-List
       (Π ((E U)
           (X U))
          (-> (List E) X (-> E (List E) X)
              X)))
(define iter-List
  (λ (E X)
    (λ (es b f)
      (rec-List es
                b
                (λ (e es rec-n-1)
                  (f e es))))))

(claim step-reverse
       (Π ((E U))
          (-> E (List E) (List E)
              (List E))))
(define step-reverse
  (λ (E)
    (λ (e es reverse-es)
      (snoc E reverse-es e))))

(claim reverse
       (Π ((E U))
          (-> (List E)
              (List E))))
(define reverse
  (λ (E)
    (λ (es)
      (rec-List es
                (the (List E) nil)
                (step-reverse E)))))


(claim step-concat
       (Π ((E U))
          (-> E (List E) (List E)
              (List E))))
(define step-concat
  (λ (E)
    (λ (e es concat-es)
      (snoc E concat-es e))))

(claim concat
       (Π ((E U))
          (-> (List E) (List E)
              (List E))))
(define concat
  (λ (E)
    (λ (xs ys)
      (rec-List (reverse E ys)
                xs
                (step-concat E)))))

(claim kartoffelmad
       (List Atom))
(define kartoffelmad
  (append Atom
          (concat Atom
                  toppings condiments)
          (reverse Atom
                   (:: 'plate
                       (:: 'rye-bread nil)))))
