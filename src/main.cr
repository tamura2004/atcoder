require "crystal/indexable"

a = [1,1,1,1,1,3]
b = a.tally

pp! b[0]
pp! b[1]
pp! b[1].class
pp! a.compress
pp! [2,0,1].idx