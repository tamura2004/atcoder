# クエリ先読み
# コストの昇順
# 追加はバスグラフで良い

require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i64)
uf = n.to_uf

ans = 0_i64

kca = Array.new(m) do
  k, c = gets.to_s.split.map(&.to_i64)
  a = gets.to_s.split.map(&.to_i.pred)
  { c, k, a }
end.sort

kca.each do |c, k, a|
  a.each_cons_pair do |v, nv|
    next if uf.same?(v, nv)
    uf.unite v, nv
    ans += c
  end
end

if uf.size == 1
  pp ans
else
  pp -1
end
