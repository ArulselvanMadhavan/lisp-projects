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

;; Double = twice

(claim double
       (-> Nat
           Nat))
(define double
  (λ (n)
    (iter-Nat n
              0
              (+ 2))))

(double 2)
(iter-Nat 3
          0
          (+ 2))

(+ 2 (iter-Nat 2
               0
               (+ 2)))
(+ 2 (+ 2 (iter-Nat 1
                    0
                    (+ 2))))
(+ 2 (+ 2 (+ 2 (iter-Nat 0
                         0
                         (+ 2)))))

(claim twice
       (-> Nat
           Nat))
(define twice
  (λ (n)
    (+ n n)))
(twice 3)
(iter-Nat 3
          3
          (λ (+n-1)
            (add1 +n-1)))
(add1 (add1 (add1 3)))

;; (claim twice=double
;;        (Π ((n Nat))
;;           (= Nat (twice n) (double n))))
;; (define twice=double
;;   (λ (n)
;;     ))

(claim mot-add1+=+add1
       (-> Nat Nat
           U))
(define mot-add1+=+add1
  (λ (j k)
    (= Nat
       (add1 (+ k j))
       (+ k (add1 j)))))

(claim step-add1+=+add1
       (Π ((j Nat)
           (n-1 Nat))
          (-> (mot-add1+=+add1 j n-1)
              (mot-add1+=+add1 j (add1 n-1)))))
(define step-add1+=+add1
  (λ (j n-1)
    (λ (add1+=+add1)
      (cong add1+=+add1
            (+ 1)))))

(claim add1+=+add1
       (Π ((n Nat)
           (j Nat))
          (= Nat
             (add1 (+ n j))
             (+ n (add1 j)))))
(define add1+=+add1
  (λ (n j)
    (ind-Nat n
             (mot-add1+=+add1 j)
             (same (add1 j))
             (step-add1+=+add1 j))))


;; Prove twice = double
(claim mot-twice=double
       (-> Nat
           U))
(define mot-twice=double
  (λ (k)
    (= Nat
       (twice k)
       (double k))))

(claim mot-step-twice=double
       (-> Nat Nat
           U))
(define mot-step-twice=double
  (λ (n-1 k)
    (= Nat
       (add1 k)
       (add1 (add1 (double n-1))))))

(claim step-twice=double
       (Π ((n-1 Nat))
          (-> (mot-twice=double n-1)
              (mot-twice=double (add1 n-1)))))
(define step-twice=double
  (λ (n-1)
    (λ (twice=double-previous)
      (replace (add1+=+add1 n-1 n-1)
               (mot-step-twice=double n-1)
               (cong twice=double-previous
                     (+ 2))))))

(claim twice=double
       (Π ((n Nat))
          (= Nat (twice n) (double n))))
(define twice=double
  (λ (n)
    (ind-Nat n
             mot-twice=double
             (same zero)
             step-twice=double)))


(claim twice=double-of-17
       (= Nat (twice 17) (double 17)))
(define twice=double-of-17
  (twice=double 17))

(claim twice=double-of-17-again
       (= Nat (twice 17) (double 17)))
(define twice=double-of-17-again
  (same 34))

;; Now double-Vec
(claim base-double-Vec
       (Π ((E U))
          (-> (Vec E zero)
              (Vec E (double zero)))))
(define base-double-Vec
  (λ (E)
    (λ (es)
      vecnil)))

(claim mot-double-Vec
       (-> U Nat
           U))
(define mot-double-Vec
  (λ (E k)
    (-> (Vec E k)
        (Vec E (double k)))))

(claim step-double-Vec
       (Π ((E U)
           (l-1 Nat))
          (-> (-> (Vec E l-1)
                  (Vec E (double l-1)))
              (-> (Vec E (add1 l-1))
                  (Vec E (double (add1 l-1)))))))
(define step-double-Vec
  (λ (E l-1)
    (λ (double-Vec-l-1)
      (λ (es)
        (vec:: (head es)
               (vec:: (head es)
                      (double-Vec-l-1
                       (tail es))))))))

(claim double-Vec
       (Π ((E U)
           (l Nat))
          (-> (Vec E l)
              (Vec E (double l)))))
(define double-Vec
  (λ (E l)
    (ind-Nat l
             (mot-double-Vec E)
             (base-double-Vec E)
             (step-double-Vec E))))

;; Now twice-Vec


(claim twice-Vec
       (Π ((E U)
           (l Nat))
          (-> (Vec E l)
              (Vec E (twice l)))))
(define twice-Vec
  (λ (E l)
    (λ (es)
      (replace (symm (twice=double l))
               (λ (k)
                 (Vec E k))
               (double-Vec E l es)))))


