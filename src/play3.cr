require "crystal/indexable"

a = [1,2,3,1,2,3]
n = a.size
ans = n.times.select{|i| a[i] == a.min }.max
pp ans
