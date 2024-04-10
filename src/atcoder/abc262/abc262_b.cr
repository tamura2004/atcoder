require "crystal/bitset"

n, m = gets.to_s.split.map(&.to_i64)
g = Array.new(n){ n.to_bitset }

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  g[v].set(nv)
  g[nv].set(v)
end

ans = (0...n).sum do |a|
  (a.succ...n).sum do |b|
    (g[a] & g[b]).popcount * g[a].get(b)
  end
end

pp ans // 3
