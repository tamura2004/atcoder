# プリム法で全域木を求めるのと同じ
# x-y座標別に隣の点のみ考慮すればよい

require "crystal/priority_queue"
require "crystal/union_find"
require "crystal/complex"

n = gets.to_s.to_i
a = Array.new(n) { C.read }
uf = n.to_uf
pq = PriorityQueue(Tuple(Int64,Int32,Int32)).lesser

(0...n).to_a.sort_by{|i|a[i].x}.each_cons_pair do |i,j|
  pq << { (a[j] - a[i]).x, i, j }
end

(0...n).to_a.sort_by{|i|a[i].y}.each_cons_pair do |i,j|
  pq << { (a[j] - a[i]).y, i, j }
end

ans = 0_i64
while pq.size > 0
  cost, i, j = pq.pop
  next if uf.same?(i, j)

  uf.unite(i, j)
  ans += cost
end

pp ans
