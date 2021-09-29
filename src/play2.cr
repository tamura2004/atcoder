require "crystal/complex"

v = C.new 100,2
nv = C.new 100, 100
a = v.vertial_bisector(nv)

v = C.new 100,100
nv = C.new 100, 2
b = v.vertial_bisector(nv)

pp! a
pp! b