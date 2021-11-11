require "crystal/union_find"
require "crystal/priority_queue"

n, m = gets.to_s.split.map(&.to_i)
uf = n.to_uf

m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  uf.unite v, nv
end

q = PriorityQueue(Tuple(Int64,Int32)).lesser
a = gets.to_s.split.map(&.to_i64)
a.each_with_index do |cost, v|
  q << {cost, v}
end
