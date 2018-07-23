;; p = 0
;; q = 1
;; b = 0
;; a = 1
;; First iteration:
;; a' = bq + aq + ap; a' = b + a
;; b' = bp + aq; b' = a
;; Second iteration:
;; a'' = b'q + a'q + a'p
;; a'' = b' + a' = a + b + a = 2a + b
;; b'' = b'p + a'q
;; b'' = a' = b + a
;;                                         ; p' = p + 1
;;                                         ; q' = q

(defun square (x)
  (* x x))

(defun fib-iter (a b p q n)
  (cond ((= n 0) b)
        ((cl-evenp n) (fib-iter a b
                                (+ (square p)
                                   (square q))
                                (+ (* 2 p q)
                                   (square q))
                                (/ n 2)))
        (t (fib-iter (+ (* b q) (* a q) (* a p))
                     (+ (* b p) (* a q))
                     p
                     q
                     (- n 1)))))

(defun fib (n)
  (fib-iter 1 0 0 1 n))

(fib 8)
