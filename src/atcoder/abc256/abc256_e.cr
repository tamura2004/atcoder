# 嫌いな人のグラフを考えると、全て出次数が１
# これは、連結成分毎にしっぽのついたループになる
# ループの中の最小値の合計が答え
# ループは問題の制約からSCCで求められる

require "crystal/graph/scc"

n = gets.to_s.to_i
x = gets.to_s.split.map(&.to_i.pred)
c = gets.to_s.split.map(&.to_i64)

g = Graph.new(n)
x.each_with_index do |nv, v|
  g.add v, nv, origin: 0, both: false
end

cg, vs, ix = SCC.new(g).solve

ans = 0_i64
vs.each do |set|
  next if set.size == 1
  ans += set.to_a.min_of { |i| c[i] }
end

pp ans
