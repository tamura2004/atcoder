(use gauche.array)
(use srfi-42)

(define h (read))
(define w (read))
(define a (tabulate-array (shape 0 h 0 w) (^(x y) (read))))

(define (++ x) (+ x 1))
(define (-- x) (- x 1))
(define (mod7 x) (modulo (-- x) 7))
(define (up? x y d) (= (+ x d) y))

(define yoko
  (vector-ec (: y h)
    (sum-ec (: x w)
      (array-ref a y x))))

(define tate
  (vector-ec (: x w)
    (sum-ec (: y h)
      (array-ref a y x))))

(do-ec (: y h)
  (:let row
    (list-ec (: x w)
      (:let i (vector-ref yoko y))
      (:let j (vector-ref tate x))
      (:let k (array-ref a y x))
      (- (+ i j) k)))
  (print
    (string-join
      (map number->string row) " ")))
