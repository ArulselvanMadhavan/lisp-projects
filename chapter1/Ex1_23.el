(defun square (x)
  (* x x))

(defun divides? (a b)
  (= (% a b) 0))

(defun next (divisor)
  (cond ((= divisor 2) 3)
        ()))

(defun find-divisor (n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (t (find-divisor n (next test-divisor)))))

(defun smallest-divisor (n)
  (find-divisor n 2))

(defun prime? (n)
  (= (smallest-divisor n) n))
