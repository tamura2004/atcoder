(defn g [x]
  (let [q (quot x 10) r (mod x 10)]
    (* 10 (if (< r 5) q (inc q)))))
(defn f [x k]
  (let [p10k (long (Math/pow 10 k))]
  (->
    (if (= k 0) x (f x (dec k)))
    (quot p10k)
    g
    (* p10k))))
(def x (read))
(def k (read))
(println (f x (dec k)))