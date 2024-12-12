(defn pp [v] (printf "%m" v))

(defn- partition-slice
  [f n ind step]
  (var [start end] [0 n])
  (def len (length ind))
  (def parts (+ 1 (math/floor (/ (- len n) step))))
  (def ret (array/new-filled parts))
  (forv k 0 parts
    (set end (+ start n))
    (put ret k (f ind start end))
    (+= start step))
  (if (< end len)
    (array/push ret (f ind start)))
  ret)

(defn partition
  [n ind &opt step]
  (default step n)
  (partition-slice tuple/slice n ind step))
  
(def grammar ~{
  :main (split "\n" (group :line))
  :line (split :s (number :d+))
})
