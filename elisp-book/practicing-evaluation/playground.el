;; parenthesis tell the interpreter to treat the enclosed content as function and not as variables.

;; C-u C-x C-e
(buffer-name)"playground.el"
(buffer-file-name)"/home/arul/dev/lisp-projects/elisp-book/practicing-evaluation/playground.el"

;; Getting the actual buffer
(current-buffer)
;; Get the other buffer(that is not in the frame)
(other-buffer)
;; Switching to buffer
(switch-to-buffer (other-buffer))
;; Buffer-size
(buffer-size)
;; (point)
(point)
(point-min)
(point-max)
