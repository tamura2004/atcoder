require "crystal/abstruct_graph/dijkstra"
include AbstructGraph

record V, v : Int32, rank : Int32
record E, v : V, nv : V, color : Int32
record S, cost : Int64, v : V do
  include Comparable(S)

  def <=>(b : self)
    cost <=> b.cost
  end
end

n, m, q, l = gets.to_s.split.map(&.to_i)
g = Graph(V, E).new

RED  = 1
BLUE = 2

m.times do
  i, j, color = gets.to_s.split.map(&.to_i)
  33.times do |rank|
    2.times do
      i, j = j, i
      v = V.new(i, rank)
      nv = V.new(j, rank + (color == BLUE ? 1 : 0))
      e = E.new(v, nv, color)
      g.add v, e
    end
  end
end

nex = ->(s : S, e : E) {
  if e.color == RED
    S.new(s.cost + 2_i64 ** s.v.rank, e.nv)
  else
    S.new(s.cost * 2, e.nv)
  end
}

v = V.new(1, 0)
init = S.new(1_i64, v)
dp = Dijkstra(V, E, S).new(g, nex).solve(init)

q.times do
  t = gets.to_s.to_i
  ans = Int64::MAX
  34.times do |rank|
    if cnt = dp[V.new(t, rank)]
      next if cnt == 0
      chmin ans, cnt
    end
  end
  pp ans
end
