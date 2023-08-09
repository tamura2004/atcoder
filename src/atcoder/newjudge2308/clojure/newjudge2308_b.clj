(defn pow10 [x] (long (Math/pow 10 x)))
(defn g [x]
  (let [q (quot x 10) r (mod x 10)]
    (* 10 ((if (< r 5) identity inc) q))))
(defn f [x k]
  (let [pow10k (pow10 k)]
    (* pow10k
      (g
        (quot
          (if (= k 0) x (f x (dec k)))
          pow10k)))))
(def x (read))
(def k (read))
(println (f x (dec k)))