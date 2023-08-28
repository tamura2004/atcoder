(defun getv (n)
  (if (zerop n)
    nil
    (cons (read) (getv (- n 1)))))

(defun zip (xs ys)
  (if (or (null xs) (null ys))
    nil
    (cons (list (car xs) (car ys)) (zip (cdr xs) (cdr ys)))))

(defun iota (n)
  (if (zerop n)
    nil
    (cons n (iota (- n 1)))))


(setq n (read))
(setq h (read))
(setq x (read))
(setq potions (getv n))
(print (zip potions potions))
(print (iota 19))