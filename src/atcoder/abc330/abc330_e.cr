require "crystal/cc"
require "crystal/st"

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

qs = (0...q).map do
  i, x = gets.to_s.split.map(&.to_i64)
  i -= 1
  {i , x}
end

xs = qs.map(&.[1])

keys = Set(Int64).new
a.each do |v|
  keys << v - 1 if v > 0
  keys << v
  keys << v + 1
end

xs. each do |v|
  keys << v - 1 if v > 0
  keys << v
  keys << v + 1
end

cc = CC.new(keys: keys.to_a)
values = cc.ref.map do |v|
  {0_i64, v}
end
st = values.to_st_min


INF = Int64::MAX//4

a.each do |v|
  cnt, nv = st[cc[v]]
  st[cc[v]] = {cnt + 1, nv}
end

qs.each do |i, x|
  v = a[i]
  cnt, nv = st[cc[v]]
  st[cc[v]] = { cnt - 1, nv }

  cnt, nv = st[cc[x]]
  st[cc[x]] = { cnt + 1, x }
  a[i] = x

  pp cc[st[0..][1]]
end

