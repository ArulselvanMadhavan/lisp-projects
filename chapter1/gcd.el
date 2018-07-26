(defun remainder (a b)
  (% a b))

(defun gcd (a b)
  (if (= b 0)
      a
    (gcd b (remainder a b))))

(gcd 18 12)
