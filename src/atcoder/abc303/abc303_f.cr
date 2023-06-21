require "crystal/deletable_priority_queue"
require "crystal/indexable"

# 時間を逆回しで考える
# 呪文si={ti,di}をt順に並べ替えて、0 < t1 < t2 < ... < tnとする
# t0 = 0_i64と置く
# 最初のi < t1秒までは、全呪文が条件同じ、これを集合Xとする
#   Σ 0 < i <= t1, max di * i
# = max(di) * Σ t0 <= i < t1, i
# = max(di) * (t0...t1).sum
# t1 <= i < t2の間、s1を集合Xから除外し、集合Yに入れる
# pq_y = max(ti * di)がYの最大ダメージ
# pq_x = max(di) * (t0...t2).sum がXの最大ダメージ
#
# 各区間で、ダメージ = dmを累積する
# 最大ダメージを与えても倒せない：答えに区間の長さを足して次の区間へ
# 〃　倒せる：X,Yの最大値で二分探索

require "big"
INF = 2e18.to_big_i

n, h = gets.to_s.split.map(&.to_i64.to_big_i)
spells = Array.new(n) do
  t, d = gets.to_s.split.map(&.to_i64.to_big_i)
  {t, d}
end.sort.reverse.uniq(&.first).reverse

ts = [0.to_big_i] + spells.map(&.[0]) + [INF]

pq_x = DPQ(BigInt).greater
pq_y = DPQ(BigInt).greater
pq_x << 0.to_big_i
pq_y << 0.to_big_i
spells.each do |t, d|
  pq_x << d
end

dm = 0.to_big_i  # 累積ダメージ
ans = 0.to_big_i # 必要ターン数

(n + 1).times do |i|
  lo, hi = ts[i], ts[i + 1]
  # 以下３行バグ、まとめて計算してはいけない
  dm_max_x = pq_x.empty? ? 0.to_big_i : pq_x[0] * (lo...hi).sum
  dm_max_y = pq_y.empty? ? 0.to_big_i : pq_y[0] * (lo...hi).size
  dm_max = Math.max dm_max_x, dm_max_y

  if dm + dm_max < h
    dm += dm_max
    ans = hi - 1
  else
    turn = (lo..hi).bsearch do |x|
      h - dm <= pq_x[0] * (lo...x).sum ||
      h - dm <= pq_y[0] * (lo...x).size
    end
    
    # pp! [lo,hi,turn,dm,h]
    # pp! pq_x[0] * (lo..7).sum
    # pp! pq_y[0] * (lo..7).size
    ans = turn.not_nil! - 1
    quit ans
  end

  if 0 <= i < n
    t, d = spells[i]
    pq_x.delete(d)
    pq_y << d * t
  end
end
