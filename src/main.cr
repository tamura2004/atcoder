require "crystal/boston_mori"

a = [1, -1]
b = [1, -2]

pp BostonMori.new(a,b).solve(0)
