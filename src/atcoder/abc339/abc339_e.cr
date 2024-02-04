require "crystal/st"

n, d = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.pred)

st = Array.new(a.max + 1, 0_i64).to_st_max

n.times do |i|
  pre = (st[a[i]-d..a[i]+d]? || 0_i64).not_nil!
  st[a[i]] = pre + 1
end

pp st[0..]