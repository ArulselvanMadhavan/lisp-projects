;; -*- lexical-binding: t -*-
(require 'seq)
(require 'pcase)

(defun square (x)
  (* x x))

(defun divides? (a b)
  (= (% a b) 0))

(defun find-divisor (n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (t (find-divisor n (+ test-divisor 1)))))

(defun smallest-divisor (n)
  (find-divisor n 2))

(defun prime? (n)
  (= (smallest-divisor n) n))

(prime? 13)
(print 13)
(cons 1 2)
(defun report-prime (n elapsed-time)
  (print " *** ")
  (print elapsed-time)
  (list n elapsed-time))

(defun start-prime-test (n start-time)
  (if (prime? n)
      (report-prime n (- (float-time) start-time))))

(defun timed-prime-test (n)
  (print n)
  (start-prime-test n (float-time)))

(smallest-divisor 127)
(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)

(defun expmod (base exp m)
  (cond ((= exp 0) 1)
        ((cl-evenp exp) (% (square (expmod base (/ exp 2) m)) m))
        (t (% (* base (expmod base (- exp 1) m)) m))))

(expmod 4 3 5)

(defun fermat-test (n)
  (defun try-it (a)
    (= (expmod a n n) a))
  (try-it (+ 1 (cl-random (- n 1)))))

(defun fast-prime (n times)
  (cond ((= times 0) t)
        ((fermat-test n) (fast-prime n (- times 1)))
        (t nil)))

(fast-prime 16 3)
(provide 'primality)
