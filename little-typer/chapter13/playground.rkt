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

(claim double
       (-> Nat
           Nat))
(define double
  (λ (n)
    (iter-Nat n
              0
              (+ 2))))

(claim Even
       (-> Nat
           U))
(define Even
  (λ (n)
    (Σ ((half Nat))
       (= Nat n (double half)))))

(claim Odd
       (-> Nat
           U))
(define Odd
  (λ (n)
    (Σ ((haf Nat))
       (= Nat n (add1 (double haf))))))

;; Statement: Every national number is either odd or even
(claim mot-even-or-odd
       (-> Nat
           U))
(define mot-even-or-odd
  (λ (k)
    (Either (Even k) (Odd k))))

;; Prood needs an ind-Nat
(claim zero-is-even
       (Even 0))
(define zero-is-even
  (cons 0
        (same 0)))

;; Statement 4: If n is even, then (add1 n) is Odd
(claim add1-even->odd
       (Π ((n Nat))
          (-> (Even n)
              (Odd (add1 n)))))
(define add1-even->odd
  (λ (n en)
    (cons (car en)
          (cong (cdr en) (+ 1)))))

(claim add1-odd->even
       (Π ((n Nat))
          (-> (Odd n)
              (Even (add1 n)))))
(define add1-odd->even
  (λ (n on)
    (cons (add1 (car on))
          (cong (cdr on) (+ 1)))))

(claim base-even-or-odd
       (Either (Even zero) (Odd zero)))
(define base-even-or-odd
  (left zero-is-even))

(claim step-even-or-odd
       (Π ((n-1 Nat))
          (-> (mot-even-or-odd n-1)
              (mot-even-or-odd (add1 n-1)))))
(define step-even-or-odd
  (λ (n-1)
    (λ (eo-prev)
      (ind-Either eo-prev
                  (λ (e-or-o-prev)
                    (mot-even-or-odd (add1 n-1)))
                  (λ (e-prev)
                    (right (add1-even->odd n-1 e-prev)))
                  (λ (o-prev)
                    (left (add1-odd->even n-1 o-prev)))))))
(claim even-or-odd
       (Π ((n Nat))
          (Either (Even n) (Odd n))))
(define even-or-odd
  (λ (n)
    (ind-Nat n
             mot-even-or-odd
             base-even-or-odd
             step-even-or-odd)))

;; Same as chain
(even-or-odd 2)
(ind-Nat 2
         mot-even-or-odd
         base-even-or-odd
         step-even-or-odd)
(step-even-or-odd 1
                  (ind-Nat 1
                           mot-even-or-odd
                           base-even-or-odd
                           step-even-or-odd))
