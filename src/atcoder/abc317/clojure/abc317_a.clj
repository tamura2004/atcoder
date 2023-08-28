(def n (read))
(def h (read))
(def x (read))
(defrecord Potion[id hp])

(def potions (map #(->Potion (inc %) (read)) (range 0 n)))
(def ans (filter #(<= x (+ h (:hp %))) potions))
(println (:id (first ans)))
