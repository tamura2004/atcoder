require "crystal/indexable"

a = [1,3,5,7,9]
i = a.count_less(4)
j = a.count_less(7)
pp [i,j]