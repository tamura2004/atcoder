(def n (read))
(def s (read-line))
(def q (read))
(def queries (map (fn [i] [i (read) (read) (read)]) (range 0 q)))
(def maxi
  (let [type2or3 (filter #(not= 1 (get % 1)) queries)]
    (if (= 0 (count type2or3)) -1
      (get (last type2or3) 0))))
(require '[clojure.string :as str])
(println (str/split s #" "))