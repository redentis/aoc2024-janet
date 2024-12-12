(use ./prelude)

(def grammar ~{
  :main (split "\n" (group :line))
	:line (* (number :d+) :s+ (number :d+))
})

# parse the input stream into the lists -- left and right
(def input 
	(->> (string/trim (file/read stdin :all))
		(peg/match grammar)
		(apply map tuple)
		(map sorted)))

# part 1
# calculate the sum of distances (absolute value of differences)
(->> input
		(apply map -)
		(map math/abs)
		(reduce + 0)
		(debug))

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
