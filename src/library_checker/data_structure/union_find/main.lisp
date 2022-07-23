(defclass union-find () (
  (n :initarg :n :accessor n)
  (par :initarg :par :accessor par)
  (rank :initarg :rank :accessor rank)))

(defun iota (n)
  (let ((a (make-array n)))
    (dotimes (i n) (setf (aref a i) i))
    a))

(defun make-union-find (n)
  (make-instance 'union-find
    :n n
    :par (iota n)
    :rank (make-array n :initial-element 1)))

(defmethod get-par ((uf union-find) v) (aref (par uf) v))
(defmethod get-rank ((uf union-find) v) (aref (rank uf) v))
(defmethod set-par ((uf union-find) v pv) (setf (aref (par uf) v) pv))
(defmethod set-rank ((uf union-find) v x) (setf (aref (rank uf) v) x))
(defmethod add-rank ((uf union-find) v x) (set-rank uf v (+ x (get-rank uf v))))

(defmethod root ((uf union-find) v)
  (if (= (get-par uf v) v)
    v
    (set-par uf v (root uf (get-par uf v)))))

(defmethod unite ((uf union-find) v nv)
  (let ((v (get-par uf v)) (nv (get-par uf nv)))
    (if (> (get-rank uf v) (get-rank uf nv))
      (unite uf nv v)
      (progn
        (set-par uf v (get-par uf nv))
        (add-rank uf nv (get-rank uf v))))))

(defmethod same ((uf union-find) v nv)
  (= (root uf v) (root uf nv)))

(defvar uf (make-union-find (read)))
(dotimes (i (read))
  (if (= (read) 0)
    (unite uf (read) (read))
    (format t "~d~%" (if (same uf (read) (read)) 1 0))))