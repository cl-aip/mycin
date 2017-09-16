;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;; Code from Paradigms of AI Programming
;;; Copyright (c) 1991 Peter Norvig

(defun rest2 (x)
  "The rest of a list after the first TWO elements."
  (rest (rest x)))

(defun partition-if (pred list)
  "Return 2 values: elements of list that satisfy pred,
  and elements that don't."
  (let ((yes-list nil)
        (no-list nil))
    (dolist (item list)
      (if (funcall pred item)
          (push item yes-list)
          (push item no-list)))
    (values (nreverse yes-list) (nreverse no-list))))