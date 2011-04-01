(def x 5)
(def lst '(a b c))
`(fred x ~x lst ~@lst 7 8 :nine)
