#lang pie

(claim Maybe
       (-> U
           U))
(define Maybe
  (λ (X)
    (Either X Trivial)))

(claim nothing
       (Π ((E U))
          (Maybe E)))
(define nothing
  (λ (E)
    (right sole)))

(claim just
       (Π ((E U))
          (-> E
              (Maybe E))))
(define just
  (λ (E)
    (λ (e)
      (left e))))

(claim maybe-head
       (Π ((E U))
          (-> (List E)
              (Maybe E))))
(define maybe-head
  (λ (E)
    (λ (es)
      (rec-List es
                (nothing E)
                (λ (h tl head-tail)
                  (just E h))))))

(claim maybe-tail
       (Π ((E U))
          (-> (List E)
              (Maybe (List E)))))
(define maybe-tail
  (λ (E)
    (λ (es)
      (rec-List es
                (nothing (List E))
                (λ (h tl h-tl)
                  (just (List E) tl))))))

(claim step-list-ref
       (Π ((E U))
          (-> Nat
              (-> (List E)
                  (Maybe E))
              (-> (List E)
                  (Maybe E)))))
(define step-list-ref
  (λ (E)
    (λ (n-1 list-ref-prev)
      (λ (es)
        (ind-Either (maybe-tail E es)
                    (λ (maybe-tl)
                      (Maybe E))
                    (λ (tl)
                      (list-ref-prev tl))
                    (λ (empty)
                      (nothing E)))))))
(claim list-ref
       (Π ((E U))
          (-> Nat (List E)
              (Maybe E))))
(define list-ref
  (λ (E n)
    (rec-Nat n
               (maybe-head E)
               (step-list-ref E))))

(claim Fin
       (-> Nat
           U))
(define Fin
  (λ (n)
    (iter-Nat n
              Absurd
              Maybe)))

(Fin 1)
(Fin 0)
(Fin 2)

(claim fzero
       (Π ((n Nat))
          (Maybe (Fin n))))
(define fzero
  (λ (n)
    (nothing (Fin n))))

(claim fadd1
       (Π ((n Nat))
          (-> (Fin n)
              (Fin (add1 n)))))
(define fadd1
  (λ (n)
    (λ (i-1)
      (just (Fin n) i-1))))

;; (claim vec-ref
;;        (Π ((E U)
;;            (l Nat))
;;           (-> (Fin l) (Vec E l)
;;               E)))
;; (define vec-ref
;;   (λ (E l)
;;     (λ (fin-l))))
