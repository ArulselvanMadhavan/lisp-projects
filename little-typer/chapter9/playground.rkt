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


(claim incr
       (-> Nat
           Nat))
(define incr
  (λ (n)
    (iter-Nat n
              1
              (+ 1))))

(claim mot-step-incr=add1
       (-> Nat Nat
           U))
(define mot-step-incr=add1
  (λ (n-1 k)
    (= Nat
       (add1
        (incr n-1))
       (add1 k))))

(claim step-incr=add1
       (Π ((n-1 Nat))
          (-> (= Nat
                 (incr n-1)
                 (add1 n-1))
              (= Nat
                 (add1 (incr n-1))
                 (add1 (add1 n-1))))))
(define step-incr=add1
  (λ (n-1)
    (λ (incr=add1-n-1)
      (replace incr=add1-n-1
               (mot-step-incr=add1 n-1)
               (same (add1 (incr n-1)))))))


(claim base-incr=add1
       (= Nat (incr zero) (add1 zero)))
(define base-incr=add1
  (same (add1 zero)))

(claim mot-incr=add1
       (-> Nat
           U))
(define mot-incr=add1
  (λ (n)
    (= Nat (incr n) (add1 n))))

(claim incr=add1
       (Π ((n Nat))
          (= Nat (incr n) (add1 n))))
(define incr=add1
  (λ (n)
    (ind-Nat n
             mot-incr=add1
             base-incr=add1
             step-incr=add1)))
