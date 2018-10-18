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
