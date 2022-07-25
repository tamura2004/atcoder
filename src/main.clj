(def n (read))
(def q (read))
(def uf (to-array (for [i (range 0 n)] i)))
(defn uf-root [uf v] (aset uf v (if (= (aget uf v) v) v (uf-root uf (aget uf v)))))
(defn uf-same [uf v nv] (= (uf-root uf v) (uf-root uf nv)))
(defn uf-unite [uf v nv]
  (let [v (uf-root uf v) nv (uf-root uf nv)]
    (when-not (= v nv) (aset uf v nv))))
(dotimes [i q]
  (let [ty (read) v (read) nv (read)]
    (if (= ty 0)
      (uf-unite uf v nv)
      (println (if (uf-same uf v nv) "Yes" "No")))))
