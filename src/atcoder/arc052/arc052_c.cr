require "crystal/graph"
require "crystal/graph/dijkstra"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  cost, v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, origin: 0
end

d = Dijkstra.new(g).solve(0)

# {頂点、typeB使用回数}を頂点として拡張ダイクストラ
alias T = Tuple(Int32,Int32)
gg = BaseGraph(T).new

n.times do |v|
  (0...n).each do |t|
    break if d[v] * (d[v] + 1) // 2 + n - 1 < t * (t + 1) // 2
    g.each_with_cost(v) do |nv, cost|
      if cost.zero? # typeA
        gg.add ({v, t}), ({nv, t}), 1_i64, both: false
      else
        gg.add ({v, t}), ({nv, t+1}), t + 1, both: false
      end
    end
  end
end

ans = Array.new(n, Int64::MAX)
dd = Dijkstra.new(gg).solve

gg.n.times do |i|
  v, t = gg.vs[i]
  chmin ans[v], dd[i]
end

puts ans.join("\n")








