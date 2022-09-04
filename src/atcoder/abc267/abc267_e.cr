require "crystal/graph"

# 逆順
# コスト大きい順（貪欲）

n,m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)

g = Graph.new(n)
m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

costs = Array.new(n, 0_i64)

g.each do |v|
  g.each(v) do |nv|
    costs[v] += a[nv]
  end
end

ans = 0_i64
seen = Array.new(n, false)
costs.zip(0..).sort.reverse_each do |_, v|
  # 逆順に点を追加
  seen[v] = true
  cost = 0_i64
  g.each(v) do |nv|
    if seen[nv]
      cost += a[nv]
    end
  end

  chmax ans, cost
end

pp ans


