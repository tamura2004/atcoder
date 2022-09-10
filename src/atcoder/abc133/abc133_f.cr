require "crystal/graph"
require "crystal/graph/h_l_decomposition"

n, q = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

colors = Array.new(n - 1, 0)
(n - 1).times do |i|
  v, nv, color, cost = gets.to_s.split.map(&.to_i)
  g.add v, nv, cost
  colors[i] = color
end
hl = HLDecomposition.new(g, 0)

events = Array.new(n) do
  [] of {is_lca: Bool, query_id: Int32}
end

queries = Array.new(q) do |i|
  x, y, v, nv = gets.to_s.split.map(&.to_i)
  v = v.pred
  nv = nv.pred

  lca = hl.lca(v, nv)
  events[v] << {is_lca: false, query_id: i}
  events[nv] << {is_lca: false, query_id: i}
  events[lca] << {is_lca: true, query_id: i}

  {color: x, new_cost: y, v: v, nv: nv, i: i}
end

# pp! queries
# pp! events

ans = Array.new(q, 0_i64)
cnt = Array.new(n, 0_i64)
tot = Array.new(n, 0_i64)

dfs = uninitialized (Int32, Int32, Int64) -> Nil
dfs = -> (v : Int32, pv : Int32, cost: Int64) do
  events[v].each do |event|
    i = event[:query_id]
    query = queries[i]
    re_cost = cost - tot[query[:color]] + cnt[query[:color]] * query[:new_cost]

    if event[:is_lca]
      ans[i] -= re_cost
    else
      ans[i] += re_cost
    end
  end

  g.each_cost_with_index(v) do |nv, n_cost, i|
    next if nv == pv
    color = colors[i]
    cnt[color] += 1
    tot[color] += n_cost

    dfs.call(nv, v, cost + n_cost)

    cnt[color] -= 1
    tot[color] -= n_cost
  end
end
dfs.call(0, -1, 0_i64)

puts ans.join("\n")