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

(claim +1=add1
       (Π ((n Nat))
          (= Nat (+ 1 n) (add1 n))))
(define +1=add1
  (λ (n)
    (same (add1 n))))

;; Now try incr
(claim incr
       (-> Nat
           Nat))
(define incr
  (λ (n)
    (iter-Nat n
              1
              (+ 1))))

;; (= Nat (incr n) (add1 n))
;; Judgment: (incr n) is the same Nat as (add1 n)

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

;; (claim step-incr=add1
;;        (Π ((n-1 Nat))
;;           (-> (mot-incr n-1)
;;               (mot-incr (add1 n-1)))))
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
      (cong incr=add1-n-1 (+ 1)))))

(claim incr=add1
       (Π ((n Nat))
          (= Nat (incr n) (add1 n))))
(define incr=add1
  (λ (n)
    (ind-Nat n
             mot-incr=add1
             base-incr=add1
             step-incr=add1)))
;; (incr
;;  (add1 n-1))
;; (iter-Nat (add1 n-1)
;;           1
;;           (+ 1))
;; (+ 1
;;    (iter-Nat n-1
;;              1
;;              (+ 1)))
;; (add1 (iter-Nat n-1
;;                 1
;;                 (+ 1)))

