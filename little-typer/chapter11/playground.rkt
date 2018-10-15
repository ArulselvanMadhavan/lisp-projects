#lang pie

(claim treats
       (Vec Atom 3))
(define treats
  (vec:: 'kanelbullar
         (vec:: 'plattar
                (vec:: 'prinsesstarta vecnil))))

(claim drinks
       (Vec Atom 2))
(define drinks
  (vec:: 'first
         (vec:: 'second vecnil)))

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
;; New content
(claim mot-vec-append
       (Π ((E U)           
           (j Nat)
           (k Nat))
          (-> (Vec E k)
              U)))
(define mot-vec-append
  (λ (E j k)
    (λ (es)
      (Vec E (+ k j)))))

(claim step-vec-append
       (Π ((E U)
           (j Nat)
           (k Nat)
           (e E)
           (es (Vec E k)))
          (-> (mot-vec-append E j
                              k es)
              (mot-vec-append E j
                              (add1 k) (vec:: e es)))))
(define step-vec-append
  (λ (E j k-1 e es)
    (λ (vec-app-prev)
      (vec:: e vec-app-prev))))

(claim vec-append
       (Π ((E U)
           (l Nat)
           (j Nat))
          (-> (Vec E l) (Vec E j)
              (Vec E (+ l j)))))
(define vec-append
  (λ (E k j)
    (λ (es end)
      (ind-Vec k es
               (mot-vec-append E j)
               end
               (step-vec-append E j)))))

(vec-append Atom 3 2 treats drinks)

(claim mot-vec-list
       (Π ((E U)
           (l Nat))
          (-> (Vec E l)
              U)))
(define mot-vec-list
  (λ (E l)
    (λ (es)
      (List E))))

(claim step-vec-list
       (Π ((E U)
           (l-1 Nat)
           (e E)
           (es (Vec E l-1)))
          (-> (mot-vec-list E l-1 es)
              (mot-vec-list E (add1 l-1) (vec:: e es)))))
(define step-vec-list
  (λ (E l-1 e es)
    (λ (list-prev)
      (:: e list-prev))))

(claim vec->list
       (Π ((E U)
           (l Nat))
          (-> (Vec E l)
              (List E))))
(define vec->list
  (λ (E l)
    (λ (es)
      (ind-Vec l es
               (mot-vec-list E)
               nil
               (step-vec-list E)))))

(claim list->vec->list
       (Π ((E U)
           (es (List E)))
          (= (List E)
             es
             (vec->list E (length E es)
                        (list->vec E es)))))

(claim mot-list->vec->list=
       (Π ((E U))
          (-> (List E)
              U)))
(define mot-list->vec->list=
  (λ (E es)
    (= (List E)
       es
       (vec->list E (length E es)
                  (list->vec E es)))))

(claim ::-fun
       (Π ((E U))
          (-> E (List E)
              (List E))))
(define ::-fun
  (λ (E)
    (λ (e es)
      (:: e es))))

(claim step-list->vec->list=
       (Π ((E U)
           (e E)
           (es (List E)))
          (-> (mot-list->vec->list= E es)
              (mot-list->vec->list= E (:: e es)))))
(define step-list->vec->list=
  (λ (E e es)
    (λ (list->vec->list=)
      (cong list->vec->list=
            (::-fun E e)))))

(claim list->vec->list=
       (Π ((E U)
           (es (List E)))
          (= (List E)
             es
             (vec->list E (length E es)
                        (list->vec E es)))))
(define list->vec->list=
  (λ (E es)
    (ind-List es
              (mot-list->vec->list= E)
              (same nil)
              (step-list->vec->list= E))))
