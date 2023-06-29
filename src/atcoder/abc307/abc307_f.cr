require "crystal/graph"
require "crystal/priority_queue"
require "crystal/st"

INF = Int32::MAX

n, m = gets.to_s.split.map(&.to_i)
g = n.succ.to_g

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, origin: 0
end

k = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i)
a.each do |v|
  g.add 0, v, 0_i64, origin: 0
end
pp g
d = gets.to_s.to_i64
x = [0_i64] + gets.to_s.split.map(&.to_i64)
st = x.to_st_max

ans = Array.new(n + 1, INF)
q = PQ(Tuple(Int32, Int64, Int32)).lesser # 何日目、使った距離、次の点
q << {0, 0_i64, 0}

while q.size > 0
  i, cost, v = q.pop
  # pp! [i, cost, v]
  next if ans[v] != INF
  ans[v] = i

  g.each_with_cost(v) do |nv, ncost|
    next if ans[nv] != INF
    # 辺を全列挙していると考える
    if cost + ncost <= x[i]
      # 残ったコストで当日中に到着できる
      q << {i, cost + ncost, nv}
    elsif j = st.bsearch(i.succ, &.>= ncost)
      # 出来ないなら、セグ木の二分探索で最初に辺を渡れる日を見つける
      q << {j, ncost, nv}
    end
  end
end

puts ans[1..].map { |v| v == INF ? -1 : v }.join("\n")

# pp g
