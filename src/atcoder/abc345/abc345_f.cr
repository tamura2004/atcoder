# 明らかに同じ辺は２回選ぶ必要はない
# 順序も考慮不要
# 部分グラフを選ぶ
# 次数が奇数の個数がKこ
# 最初は2増える
# 以降は、+2 -2 0 のいずれか
# Kは偶数である必要がある
# 適当な最小全域木をとる
# 次数が偶数のペアを列挙

require "crystal/union_find"

n, m, k = gets.to_s.split.map(&.to_i64)
uf = n.to_uf

msp = [] of Tuple(Int64,Int64)
deg = Array.new(n, 0_i64)
ei = [] of Int64

m.times do |i|
  v, nv = gets.to_s.split.map(&.to_i64.pred)
  next if uf.same?(v, nv)
  uf.unite(v, nv)
  deg[v] += 1
  deg[nv] += 1
  msp << {v, nv}
  ei << i
end

ge = [] of Int64
uf2 = n.to_uf
msp.each_with_index do |(v, nv), i|
  if deg[v].even? && deg[nv].even? && !uf2.same?(v, nv)
    ge << i
    uf2.unite(v, nv)
  end
end

cnt = deg.count(&.odd?)

quit :No if k.odd?

ans = [] of Tuple(Int64,Int64)
quit :No if ge.size < (k - cnt) // 2

ans2 = ge.first((k - cnt)//2)
puts :Yes
puts ans2.size
puts ans2.map(&.succ).join(" ")
