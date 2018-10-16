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

(claim zero-is-even
       (Even 0))
(define zero-is-even
  (cons 0
        (same 0)))

;; Statement 1: Two greater than even number is also even
(claim +two-even
       (Π ((n Nat))
          (-> (Even n)
              (Even (+ 2 n)))))
(define +two-even
  (λ (n en)
    (cons (add1 (car en))
          (cong (cdr en) (+ 2)))))

;; Statement 2: two is even
(claim two-is-even
       (Even 2))
(define two-is-even
  (+two-even 0 zero-is-even))

;; Statement 3:
(claim Odd
       (-> Nat
           U))
(define Odd
  (λ (n)
    (Σ ((haf Nat))
       (= Nat n (add1 (double haf))))))

(claim one-is-odd
       (Odd 1))
(define one-is-odd
  (cons 0 (same 1)))

(claim thirteen-is-odd
       (Odd 13))
(define thirteen-is-odd
  (cons 6 (same 13)))

;; Statement 4: If n is even, then (add1 n) is Odd
(claim add1-even->odd
       (Π ((n Nat))
          (-> (Even n)
              (Odd (add1 n)))))
(define add1-even->odd
  (λ (n en)
    (cons (car en)
          (cong (cdr en) (+ 1)))))

;; Statement 5: If n is odd, then (add1 n) is Even
(claim add1-odd->even
       (Π ((n Nat))
          (-> (Odd n)
              (Even (add1 n)))))
(define add1-odd->even
  (λ (n on)
    (cons (add1 (car on))
          (cong (cdr on) (+ 1)))))

;; Ackermann
(claim repeat
       (-> (-> Nat
               Nat)
           Nat
           Nat))
(define repeat
  (λ (f n)
    (iter-Nat n
              (f 1)
              (λ (iter-f-n-1)
                (f iter-f-n-1)))))

(claim ackermann
       (-> Nat Nat
           Nat))
(define ackermann
  (λ (n)
    (iter-Nat n
              (+ 1)
              (λ (ack-n-1)
                (repeat ack-n-1)))))
