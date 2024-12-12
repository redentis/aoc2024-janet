(use ./prelude)

(def grammar ~{
  :main (split "\n" (group :line))
  :line (split :s (number :d+))
})

(def input 
  (->> (file/read stdin :all)
    (string/trim)
    (peg/match grammar)))
    
# part 1
(defn is-safe? [tolerance report]
  (let [n_pairs   (- (length report) 1)
        pairs     (partition 2 report 1)
        [ha hb]   (pairs 0)
        compare   (if (< ha hb) < >)]
    (def trend 
      (count
        (fn [p] (apply compare p))
        pairs))
    (def limited_change
      (count
        (fn [[a b]] (let [delta (math/abs (- a b))] (and (< delta 4) (> delta 0))))
        pairs))
    # (pp [report tolerance n_pairs trend limited_change])
    (>= tolerance (+ (- n_pairs trend) (- n_pairs limited_change)))))

(defn part-1 [input]
  (count (partial is-safe? 0) input))

(pp (part-1 input))

# part 2

(defn part-2 [input]
  (count (partial is-safe? 1) input))

(pp (part-2 input))
