;; -*- lexical-binding: t -*-
(defun * (a b)
    (if (= b 0)
        0
      (+ a (* a (- b 1)))))

(* 4 3)

;; Doubles an integer
(defun double (x)
  (* x 2))

(defun halve (x)
  (/ x 2))

// 4 3 res:0
// 4 2 (res + a = 4)
// 4 1 (a + (* 2 res) = 12)
// b * n = 1 * b * 2(n/2) =
// a * b = a * (+ b res)
// 4 * 3 = 4 * (+ 2 4)
// 4 * 2 = 4 * (+ 1 8)
// 4 * 1 = 8 + 4

// a * b = res + (a * b)
// 4 * 7 = 0 + (4 * 7)
// 4 * 6 = 4 + (4 * 6)
// 4 * 3 = 4 + (8 * 3)
// 2 = 12 + (8 * 2)
// 1 = 12 + (16 * 1)


(defun mult-succ-add-rec (a b res)
  (if (= b 1)
      (+ a res)
    (cond ((cl-evenp b) (mult-succ-add-rec (double a) (halve b) res))
          (t (mult-succ-add-rec a (- b 1) (+ a res))))))

(mult-succ-add-rec 4 7 0)
