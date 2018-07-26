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

(smallest-divisor 127)

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



