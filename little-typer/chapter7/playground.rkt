#lang pie

(claim mot-peas
       (-> Nat
           U))
(define mot-peas
  (λ (k)
    (Vec Atom k)))

(claim base-peas
       (Vec Atom 0))
(define base-peas
  vecnil)

(claim step-peas
       (Π ((l-1 Nat))
          (-> (mot-peas l-1)
              (mot-peas (add1 l-1)))))
(define step-peas
  (λ (l-1)
    (λ (almost-peas)
      (vec:: 'pea almost-peas))))

(claim peas
       (Π ((l Nat))
          (Vec Atom l)))
(define peas
  (λ (l)
    (ind-Nat l
             mot-peas
             vecnil
             step-peas)))

(claim also-rec-Nat
       (Π ((X U))
          (-> Nat
              X
              (-> Nat X
                  X)
              X)))
(define also-rec-Nat
  (λ (X)
    (λ (target base step)
      (ind-Nat target
               (λ (k)
                 X)
               base
               step))))

(claim base-last
       (Π ((E U))
          (-> (Vec E (add1 zero))
              E)))
(define base-last
  (λ (E)
    (λ (es)
      (head es))))

(claim mot-last
       (-> U Nat
           U))
(define mot-last
  (λ (E k)
    (-> (Vec E (add1 k))
        E)))

(mot-last Atom 3)

(claim step-last
       (Π ((E U)
           (l-1 Nat))
          (-> (mot-last E l-1)
              (mot-last E (add1 l-1)))))
(define step-last
  (λ (E l-1)
    (λ (last-1)
      (λ (es)
        (last-1 (tail es))))))

(claim last
       (Π ((E U)
           (l Nat))
          (-> (Vec E (add1 l))
              E)))
(define last
  (λ (E)
    (λ (l)
      (ind-Nat l
               (mot-last E)
               (base-last E)
               (step-last E)))))

(claim test-vec
       (Vec Atom 2))
(define test-vec
  (vec:: 'carrot
             (vec:: 'celery
                    vecnil)))

(last Atom 1
      test-vec)

((ind-Nat (add1 zero)
          (mot-last Atom)
          (base-last Atom)
          (step-last Atom)) test-vec)

((step-last Atom zero
            (ind-Nat zero
                     (mot-last Atom)
                     (base-last Atom)
                     (step-last Atom))) test-vec)

;; (the Atom ((λ (es)
;;    ((ind-Nat zero
;;              (mot-last Atom)
;;              (base-last Atom)
;;              (step-last Atom)) (tail es))) test-vec))

((ind-Nat zero
          (mot-last Atom)
          (base-last Atom)
          (step-last Atom))
 (tail test-vec))

(base-last Atom
           (tail test-vec))
;; ((λ (es)
;;    (head es)) (tail test-vec))

(head (tail test-vec))

;; Drop - Last

(claim base-drop-last
       (Π ((E U))
          (-> (Vec E (add1 zero))
              (Vec E zero))))
(define base-drop-last
  (λ (E)
    (λ (es)
      (tail es))))

(claim mot-drop-last
       (-> U Nat
           U))
(define mot-drop-last
  (λ (E k)
    (-> (Vec E (add1 k))
        (Vec E k))))

(claim step-drop-last
       (Π ((E U)
           (l-1 Nat))
          (-> (mot-drop-last E l-1)
              (mot-drop-last E (add1 l-1)))))
(define step-drop-last
  (λ (E l-1)
    (λ (drop-1)
      (λ (es)
        (vec:: (head es)
               (drop-1 (tail es)))))))

(claim drop-last
       (Π ((E U)
           (l Nat))
          (-> (Vec E (add1 l))
              (Vec E l))))
(define drop-last
  (λ (E l)
    (ind-Nat l
             (mot-drop-last E)
             (base-drop-last E)
             (step-drop-last E))))
