require "crystal/graph"
require "crystal/graph/in_deg"

n, root = gets.to_s.split.map(&.to_i)
root = root.pred
h = gets.to_s.split.map(&.to_i64)
h[root] = 1

g = Graph.new(n)
(n-1).times do
  g.read
end

deg = InDeg.new(g).solve

# 宝石のない葉を削除
ans = (n - 1) * 2
q = Deque(Int32).new

n.times do |v|
  if deg[v] == 1 && h[v] == 0
    q << v
  end
end

while q.size > 0
  v = q.shift
  deg[v] -= 1
  ans -= 2

  g.each(v) do |nv|
    deg[nv] -= 1
    if deg[nv] == 1 && h[nv] == 0
      q << nv
    end
  end
end

pp ans


