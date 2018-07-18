;; -*- lexical-binding: t -*-
;; Pascal triangle
(require 'seq)
(require 'pcase)

(defun zip-and-add-helper (xs ys)
  "Adds two lists and appends the tail of the longer list"
  (pcase (cons (car-safe xs) (car-safe ys))
    (`(nil . nil) ())
    (`(nil . ,y) (cons y (zip-and-add-helper () (cdr-safe ys))))
    (`(,x . nil) (cons x (zip-and-add-helper (cdr-safe xs) ())))
    (`(,x . ,y) (cons (+ x y) (zip-and-add-helper (cdr-safe xs) (cdr-safe ys))))))

;; test
(zip-and-add-helper (list 1 3 3 1) (list 0 1 3 3 1))

(defun zip-and-add (xs)
  (let* ((dup (copy-sequence xs))
         (off-by-one (cons 0 dup)))
    (zip-and-add-helper xs off-by-one)))

(defun helper (n count xs)
  (cond ((= count n) xs)
        (t (print xs)
           (helper n (+ count 1) (zip-and-add xs)))))

(defun pascal-triangle (n)
  (helper n 1 (list 1)))

(pascal-triangle 5)
