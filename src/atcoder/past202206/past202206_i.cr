# 素抜け君の位置と荷物の位置の数字４つを状態としてもつ

require "crystal/graph/grid"
h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s.chars }
g = Grid.new(h,w,a)

pp g