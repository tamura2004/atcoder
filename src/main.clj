(def w (read))
(def h (read))
(def n (read))
(def xya (for [i (range n)] (list (read) (read) (read))))
(defn q [xya minx maxx miny maxy]
  (if (empty? xya) [minx maxx miny maxy]
    (let [[x y a] (first xya)]
      (case a
        1 (q (rest xya) (max x minx) maxx miny maxy)
        2 (q (rest xya) minx (min x maxx) miny maxy)
        3 (q (rest xya) minx maxx (max y miny) maxy)
        4 (q (rest xya) minx maxx miny (min y maxy))))))
(def ans (let [[minx maxx miny maxy] (q xya 0 w 0 h)]
  (if (or (> minx maxx) (> miny maxy)) 0 (* (- maxx minx) (- maxy miny)))))
(println ans)
