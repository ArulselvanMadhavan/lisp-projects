(defun find-min (a b c)
  (cond ((and (<= a b) (<= a c)) a)
        ((and (<= b a) (<= b c)) b)
        ((and (<= c a) (<= c b)) c)))

(defun find-square-sum (a b)
  (+ (* a a) (* b b)))

(defun square-larger-two (a b c)
  "Squares the larger two numbers of the 3"
  (let ((min (find-min a b c)))
    (cond ((eq min a) (find-square-sum b c))
          ((eq min b) (find-square-sum a c))
          ((eq min c) (find-square-sum c a)))))

(square-larger-two 8 4 5)
