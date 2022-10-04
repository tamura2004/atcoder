# 素抜け君の位置と荷物の位置の数字４つを状態としてもつ

require "crystal/matrix"

h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s.chars }
g = Matrix(Char).new(a)

alias Status = Tuple(Int32,Int32,Int32,Int32)
seen = Set(Status).new

sy, sx = g.index('S').not_nil!
