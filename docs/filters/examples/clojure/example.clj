;;; @export "factorial"
(defn factorial
 ([n]
  (factorial n 1))
 ([n acc]
  (if  (= n 0)   acc
   (recur (dec n) (* acc n)))))
(factorial 10)
;;; @export "list"
(def x 5)
(def lst '(a b c))
`(fred x ~x lst ~@lst 7 8 :nine)
