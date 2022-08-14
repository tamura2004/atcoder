require "crystal/weighted_graph/graph"

n = gets.to_s.to_i64
g = Graph.new(n)

(n-1).times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end

ans = Array.new(n, -1)

dfs = uninitialized Proc(Int32,Int32,Nil)
dfs = Proc(Int32,Int32,Nil).new do |v, pv|
  g[v].each do |nv, cost|
    next if nv == pv
    if cost.odd?
      ans[nv] = 1 - ans[v]
    else
      ans[nv] = ans[v]
    end
    dfs.call(nv, v)
  end
end
ans[0] = 0
dfs.call(0, -1)

puts ans.join("\n")
