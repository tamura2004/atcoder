(defstruct uf n par rank)

(defun init-uf (n)
  (let ((par (make-array n)) (rank (make-array n)))
    (dotimes (i n) (setf (aref par i) i))
    (make-uf :n n :par par :rank rank)))

(defun uf-find (uf x)
  (let ((par (uf-par uf)))
    (if (equalp x (aref par x))
      x 
      (setf (aref par x) (uf-find uf (aref par x))))))

(defun uf-unite (uf x y)
  (let* (
    (uf-x (uf-find uf x))
    (uf-y (uf-find uf y))
    (par (uf-par uf))
    (rank (uf-rank uf))
    (par-x (aref par uf-x))
    (par-y (aref par uf-y))
    (rank-x (aref rank uf-x))
    (rank-y (aref rank uf-y)))
      (if (equalp uf-x uf-y) nil
        (if (< rank-x rank-y)
          (progn
            (setf par-x par-y)
            (setf rank-y (+ rank-x rank-y)))
          (progn
            (setf par-y par-x)
            (setf rank-x (+ rank-y rank-x)))))))

(defun uf-same (uf x y)
  (equalp (uf-find uf x) (uf-find uf y)))

(let ((uf (init-uf (read))))
  (dotimes (i (read))
    (if (zerop (read))
      (uf-unite uf (read) (read))
      (format t "~d~%" (if (uf-same uf (read) (read)) 1 0)))))
