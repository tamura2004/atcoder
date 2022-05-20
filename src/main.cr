require "crystal/range_tree"

n = gets.to_s.to_i
rt = RangeTree.new(n)
a = gets.to_s.split.map(&.to_i64)

a.each_with_index do |x, y|
  rt.add y, x
end

q = gets.to_s.to_i
q.times do
  l, r, x = gets.to_s.split.map(&.to_i64)
  l = l.to_i.pred
  r = r.to_i.pred
  pp rt[l..r, x..x]
end
