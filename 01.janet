(use ./prelude)

(def input @[[3 4 2 1 3 3] [4 3 5 3 9 3]])

# part 1

# part 2

(defn summary [input]
  (reduce 
    (fn [acc n]
      (let [count (get acc n 0)]
        (put acc n (+ count 1))))
    @{}
    input))

(defn part-2 [@[left right]]
  (let [s (summary right)]
  (->> left
    (reduce
      (fn [acc n]
        (+ acc (* n (get s n 0))))
      0)
  )))

(debug (part-2 input))
