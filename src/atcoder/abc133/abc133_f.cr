require "crystal/graph"
require "crystal/graph/depth"
require "crystal/graph/h_l_decomposition"

n, q = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
colors = Array.new(n, -1)

(n - 1).times do |i|
  v, nv, color, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
  colors[i] = color.to_i.pred
end

depth = Depth.new(g).solve(0)
hl = HLDecomposition.new(g, 0)

events = Array.new(n) { [] of NamedTuple(is_lca: Bool, query_id: Int32) }
queries = Array.new(q) do |i|
  color, new_cost, v, nv = gets.to_s.split.map(&.to_i64)
  color = color.to_i.pred
  v = v.to_i.pred
  nv = nv.to_i.pred
  lca = hl.lca(v, nv)

  events[v] << { is_lca: false, query_id: i }
  events[nv] << { is_lca: false, query_id: i }
  events[lca] << { is_lca: true, query_id: i }

  { color: color, new_cost: new_cost, v: v, nv: nv }
end

ans = Array.new(q, 0_i64)
cnt = Array.new(n, 0)
tot = Array.new(n, 0_i64)

dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do

  # 頂点に登録したイベント処理
  events[v].each do |event|
    query = queries[event[:query_id]]
    ncost = depth[v] - tot[query[:color]] + cnt[query[:color]] * query[:new_cost]
    if event[:is_lca]
      ans[event[:query_id]] -= ncost * 2
    else
      ans[event[:query_id]] += ncost
    end
  end

  g.each_cost_with_index(v) do |nv, cost, i|
    next if nv == pv

    color = colors[i]
    cnt[color] += 1
    tot[color] += cost

    dfs.call(nv, v)

    cnt[color] -= 1
    tot[color] -= cost
  end
end
dfs.call(0, -1)

puts ans.join("\n")