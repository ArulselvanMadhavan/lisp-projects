#lang pie

(claim more-expectations
       (Vec Atom 3))
(define more-expectations
  (vec:: 'need-induction
         (vec:: 'understood-induction
                (vec:: 'built-function vecnil))))

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

(claim step-list-vec
       (Π ((E U))
          (-> E (List E) (Σ ((l Nat))
                            (Vec E l))
              (Σ ((l Nat))
                 (Vec E l)))))
(define step-list-vec
  (λ (E)
    (λ (e es list-vec-prev)
      (cons (add1 (car list-vec-prev))
            (vec:: e (cdr list-vec-prev))))))

;; (claim list-vec
;;        (Π ((E U))
;;           (-> (List E)
;;               (Σ ((l Nat))
;;                  (Vec E l)))))
;; ;; (define list-vec
;;   (λ (E)
;;     (λ (es)
;;       (rec-List es
;;                 (cons 0 (the (Vec E 0) vecnil))
;;                 (step-list-vec E)))))

(claim mot-replicate
       (-> U Nat
           U))
(define mot-replicate
  (λ (E k)
    (Vec E k)))

(claim step-replicate
       (Π ((E U)
           (e E)
           (l-1 Nat))
          (-> (mot-replicate E l-1)
              (mot-replicate E (add1 l-1)))))
(define step-replicate
  (λ (E e l-1)
    (λ (rep-prev)
      (vec:: e rep-prev))))

(claim replicate
       (Π ((E U)
           (l Nat))
          (-> E
              (Vec E l))))
(define replicate
  (λ (E l)
    (λ (e)
      (ind-Nat l
               (mot-replicate E)
               vecnil
               (step-replicate E e)))))

(claim mot-list
       (Π ((E U))
          (-> (List E)
              U)))
(define mot-list
  (λ (E es)
    (Vec E (length E es))))


(claim step-list->vec
       (Π ((E U)
           (e E)
           (es (List E)))
          (-> (mot-list E es)
              (mot-list E (:: e es)))))
(define step-list->vec
  (λ (E e es)
    (λ (prev)
      (vec:: e prev))))

(claim list->vec
       (Π ((E U)
           (es (List E)))
          (Vec E (length E es))))
(define list->vec
  (λ (E es)
    (ind-List es
              (mot-list E)
              vecnil
              (step-list->vec E))))
