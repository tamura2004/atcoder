# ペアの左側をカウントして、セグ木
# 右端を一つ縮める

require "crystal/st"

n, q = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars

cnt = [] of Int32
s.each_cons_pair do |i, j|
  cnt << (i == j).to_unsafe
end

st = cnt.to_st_sum

q.times do
  l, r = gets.to_s.split.map(&.to_i64)
  if l == r
    pp 0
  else
    l -= 1
    r -= 2
    pp st[l..r]
  end
end
