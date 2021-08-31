require "crystal/boston_mori"

p = [1]
q = [1,0,-1]

pp BostonMori.new(p,q).solve(2)