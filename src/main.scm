(use srfi-42)

(define (combinations xs n)
  (cond ((= n 1) (map list xs))
    (else
      (list-ec (: i xs) (: es (combinations (delete i xs) (- n 1)))
        (cons i es)))))

(print (combinations '(a b c d) 3))