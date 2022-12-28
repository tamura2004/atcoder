require "crystal/union_find"
require "crystal/number_theory/modpow"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
uf = n.to_uf

calc = ->(v : Int32, nv : Int32) do
  (modpow(a[v], a[nv], m) + modpow(a[nv], a[v], m)) % m
end

edges = [] of Tuple(Int64, Int32, Int32)
(0...n).to_a.each_combination(2) do |(i, j)|
  edges << {calc.call(i, j), i, j}
end
edges.sort!

ans = 0_i64
edges.reverse_each do |cost, v, nv|
  next if uf.same?(v, nv)
  uf.unite(v, nv)
  ans += cost
end

pp ans
