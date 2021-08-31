require "crystal/boston_mori"

a = [1]
b = [1,0,-2]

pp BostonMori.new(a,b).solve(8)