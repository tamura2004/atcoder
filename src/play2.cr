require "crystal/graph"
require "crystal/union_find_tree"

n,m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  g.add gets.to_s, both: true
end

uf = UnionFindTree.new(n)

# 全ての辺について
n.times do |v|
  g[v].each do |nv|
    (g[v] & g[nv]).each_combination(2) do |(i,j)|
      uf.unite(i,j)
    end
  end
end

n.times do |v|
  g[v].each do |nv|
    if uf.same?(v,nv)
      puts 0
      exit
    end
  end
end

nn = uf.gsize
gg = Graph.new(n)
n.times do |v|
  g[v].each do |nv|
    gg.add uf.find(v), uf.find(nv), both: true
  end
end

dp = Array.new(n, -1)
# rk.zip(0..).sort.reverse.map(&.last).each do |v|
n.times do |v|
  next if uf.find(v) != v
  next if dp[v] != -1
  q = Deque.new([v])

  while q.size > 0
    v = q.shift

    cnt = g[v].count{|nv| dp[nv] != -1}
    if cnt >= 3
      pp 0
      exit
    else
      dp[v] = 3 - cnt
    end

    g[v].each do |nv|
      next if dp[nv] != -1
      q << nv
    end
  end
end

ans = 1_i64
dp.each do |v|
  next if v == -1
  ans *= v
end

pp ans


