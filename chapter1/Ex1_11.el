;; -*- lexical-binding: t -*-

(defun f (n)
  "Recursive process of f"
  (cond ((< n 3) n)
        (t (+ (f (- n 1))
              (* 2 (f (- n 2)))
              (* 3 (f (- n 3)))))))

(defun f-rp (n counter one-less two-less three-less)
  "Recursive Procedure"
  (if (> counter n)
      one-less
    (let ((final-result 0))
      (setq final-result (+ one-less
                            (* 2 two-less)
                            (* 3 three-less)))
      (f-rp n (+ counter 1) final-result one-less two-less))))

(defun f-rp-prime (n)
  (cond ((< n 3) n)
        (t (f-rp n 3 2 1 0))))

(f 5)
(f-rp-prime 5)
;; 0 1 2 4 11
