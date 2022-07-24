require "crystal/string/z_algorithm"
require "crystal/graph/tsort"

s = gets.to_s
t = gets.to_s
n = s.size
m = t.size

g = Graph.new(n)

if n < m
  s = s * divceil(m, n)
end

cnt = ZAlgorithm.new(t + "@" + s + s).solve

n.times do |v|
  i = v + m + 1
  if cnt[i] == m
    nv = (v + m) % n
    g.add v, nv, origin: 0, both: false
  end
end

dp = Array.new(n, 0)
ts = Tsort.new(g).solve

quit -1 if ts.size < n

ts.each do |v|
  g[v].each do |nv|
    dp[nv] = dp[v] + 1
  end
end

pp dp.max
