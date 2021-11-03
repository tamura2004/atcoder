(use gauche.array)
(use gauche.collection)

(define (-- x) (- x 1))
(define h 2000)
(define w 2000)
(define a (make-u64array (shape 0 h 0 w)))
(dotimes (y h) (dotimes (x w) (array-set! a y x (* x y))))

(dotimes (y h)
  (dotimes (x w)
    (let*
      (
        [ans (array-ref a y x)]
      )
      (display ans)
      (if (= x (-- w)) (newline) (display #\space)))))
