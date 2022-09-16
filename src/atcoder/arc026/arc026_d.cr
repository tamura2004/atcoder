# コスト最小であれば貪欲法が使用できるが、比率なので難しい（例：食塩水）
# 二分探索のための判定問題を考える
# 時給の平均がx以下 <=> Σc_i // Σt_i <= x
# <=> Σc_i <= x Σt_i
# <=> Σc_i <= Σ x*t_i
# <=> Σc_i - Σ x*t_i <= 0
# <=> Σ(c_i - x*t_i) <= 0
# 必要数取って合計が0以下という問題になった
# 負数なら必ず取る。正の数なら必要なら取るを繰り返し、
# 最終合計が0以下なら成立

require "crystal/union_find"
require "crystal/priority_queue"

n,m = gets.to_s.split.map(&.to_i)

edges = Array.new(m) do
  v, nv, cost, time = gets.to_s.split.map(&.to_i64)
  v = v.to_i.pred
  nv = nv.to_i.pred
  cost = cost.to_f64
  time = time.to_f64
  {v: v, nv: nv, cost: cost, time: time}
end

# 判定問題
query = -> (x : Float64) do
  uf = n.to_uf

  pq = PQ(Tuple(Float64, Int32, Int32)).lesser
  m.times do |i|
    e = edges[i]
    pq << { e[:cost] - x * e[:time], e[:v], e[:nv] }
  end

  sum = 0.0
  while pq.size > 0
    cost, v, nv = pq.pop

    if cost < 0
      sum += cost
      uf.unite v, nv
    else
      next if uf.same?(v, nv)
      sum += cost
      uf.unite v, nv
    end
  end

  sum <= 0
end

lo = 0.0
hi = 1e9
ans = (lo..hi).bsearch(&query)

pp ans