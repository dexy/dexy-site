;;; @export "factorial"
(defn factorial
 ([n]
  (factorial n 1))
 ([n acc]
  (if  (= n 0)   acc
   (recur (dec n) (* acc n)))))
(factorial 10)

;;; @export "math"
(Math/pow 10 2)
