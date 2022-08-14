require "crystal/complex"

z = C.read
w = 8.x + 8.y
ans = (z - w).chebyshev
puts ans.odd? ? "black" : "white"
