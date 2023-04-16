# 横合計をRMaxQに入れる
# 列ごとに、削除
# 列合計＋最大
# 列ごとに、復元

require "crystal/cc"
require "crystal/st"

n = gets.to_s.to_i
tate_keys = [] of Int64
yoko_keys = [] of Int64
rcx = Array.new(n) do
  r,c,x = gets.to_s.split.map(&.to_i64)
  tate_keys << r
  yoko_keys << c
  {r,c,x}
end

tate_cc = CC.new(tate_keys)
yoko_cc = CC.new(yoko_keys)

rcx = rcx.map do |r,c,x|
  r = tate_cc[r]
  c = yoko_cc[c]
  {r,c,x}
end

tate = rcx.group_by(&.[0])
yoko = rcx.group_by(&.[1])

values = tate.keys.sort.map do |i|
  tate[i].sum(&.[2])
end

st = ST(Int64).new(
  values,
  -> (x : Int64, y : Int64) { Math.max x, y }
)

ans = 0_i64
yoko.keys.sort.each do |i|
  tot = 0_i64
  yoko[i].each do |r,c,x|
    tot += x
    st[r] -= x
  end

  chmax ans, tot + st.sum

  yoko[i].each do |r,c,x|
    st[r] += x
  end
end

pp ans

# yoko.each do |k, (r,c,x)|
#   pp [k,r,c,x]
# end


