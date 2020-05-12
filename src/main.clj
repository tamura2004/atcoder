(defn coins [x n]
  (map #(* x %) (range (inc n))))

(defn yens [xs ys zs]
  (for [x xs y ys z zs] (+ x y z)))

(def a (read))
(def b (read))
(def c (read))
(def x (read))

(->>
  (yens (coins 500 a) (coins 100 b) (coins 50 c))
  (filter (partial = x))
  (count)
  (println))
