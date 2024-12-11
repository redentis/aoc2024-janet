(use ./prelude)

(def input 
  (->> (file/read stdin :all)
    (string/trim)
    (peg/match grammar)))
    
# part 1
(defn is-safe? [report]
  (let [pairs     (partition 2 report 1)
        [ha, hb]  (pairs 0)
        compare   (if (< ha hb) < >)]
    (and (all (fn [p] (apply compare p)) pairs)
         (all (fn [[a, b]] (< 3 (math/abs (- a b)))) pairs))))

(defn part-1 [input]
  (count is-safe? input))

(debug (part-1 input))
