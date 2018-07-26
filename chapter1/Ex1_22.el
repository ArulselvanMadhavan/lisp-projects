;; -*- lexical-binding: t -*-
(require 'primality)


(defun compare-second-element (xs ys)
  (pcase-let* ((`(,_,a,_) xs))
    (pcase-let* ((`(,_,b,_) ys))
      (< a b))))

(sort (-non-nil (seq-map 'timed-prime-test (number-sequence 1000 10000))) 'compare-second-element)

;; Emacs hits max-specpdl-size errors
(sort (-non-nil (seq-map 'timed-prime-test (number-sequence 10000 100000))) 'compare-second-element)
