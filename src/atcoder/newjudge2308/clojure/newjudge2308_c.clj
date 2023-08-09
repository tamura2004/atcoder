(defn solve [bag]
  (if (< 0 (count bag))
    (let [ball (last bag)]
      (println ball)
      (solve (disj (disj bag ball) (read))))))

(def n (read))
(def balls (range (+ 2 (* 2 n))))
(def bag (apply sorted-set balls))
(solve bag)
