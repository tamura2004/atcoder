(defstruct union-find n par rank)

(defun get-par (uf v) (aref (union-find-par uf) v))
(defun get-rank (uf v) (aref (union-find-rank uf) v))
(defun set-par (uf v nv) (setf (aref (union-find-par uf) v) nv))
(defun set-rank (uf v x) (setf (aref (union-find-rank uf) v) x))
(defun add-rank (uf v x) (set-rank uf v (+ x (get-rank uf v))))

(defun iota (n)
  (let ((a (make-array n)))
    (dotimes (i n) (setf (aref a i) i))
    a))

(defun uf-make (n)
  (let ((par (iota n)) (rank (make-array n :initial-element 1)))
    (make-union-find :n n :par par :rank rank)))

(defun uf-root (uf v)
  (if (= v (get-par uf v))
    v
    (set-par uf v (uf-root uf (get-par uf v)))))

(defun uf-unite (uf v nv)
  (let ((root-v (uf-root uf v)) (root-nv (uf-root uf nv)))
    (if (> (get-rank uf root-v) (get-rank uf root-nv))
      (uf-unite uf nv v)
      (when (not (= root-v root-nv))
        (progn
          (set-par uf root-v root-nv)
          (add-rank uf root-nv (get-rank uf root-v)))))))

(defun uf-same (uf x y)
  (= (uf-root uf x) (uf-root uf y)))

(defun main (n q)
  (let ((uf (uf-make n)))
    (dotimes (i q)
      (let ((cmd (read)) (v (read)) (nv (read)))
        (if (= cmd 0)
          (uf-unite uf v nv)
          (format t "~d~%" (if (uf-same uf v nv) 1 0)))))))

(main (read) (read))