require "crystal/graph"
require "crystal/bitset"

n, m, q = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end

dp = Array.new(n) do |v|
  nil.as(Bitset?)
end

n.times do |v|
  g.each(v) do |nv|
    to = dp[nv] || [nv].to_bitset(nv + 1)
    if from = dp[v]
      to.or! from
    else
      to.set(v)
    end
    dp[nv] = to
  end
end

q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  yesno dp[nv].try &.get(v).==(1) || false
end
