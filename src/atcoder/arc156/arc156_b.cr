# k回をシミュレートする思考では間に合わない
# k回終了後、同じものをまとめられないか（高々Nオーダーで）
# k個追加するが、最大値をMとすると
# M未満の抜けたところ+1(M自身)は固定で加える
# それ以外を1~mで重複組み合わせ

require "crystal/modint9"
require "crystal/fact_table"
require "crystal/segment_tree"

n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)

st = a.max.succ.to_st_sum
a.each do |v|
  st[v] = 1
end

ans = 0.to_m

(0..k+n).each do |m|
  cnt = m - st[...m] + 1
  next if k < cnt
  ans += (m+1).h(k-cnt)
end

pp ans

