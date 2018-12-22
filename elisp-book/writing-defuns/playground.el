;; Elisp interpreter looks at the first element in a list
;; if it's a function it evaluates the function definiion
(defun multiply-by-seven (number)
  "Multiply any number by seven"
  (* 7 number))

(multiply-by-seven 45)

;; Interactive basic example
(defun multiply-by-six (NUMBER)
  "Multiply by six interactively"
  (interactive "p")
  (message "The result is %d" (* 6 NUMBER)))
