require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.chars.map(&.to_i64).sort
st = a.to_st_sum

ans = 0_i64
n.times do |i|
  ans += i * a[i] - st[...i]
end

pp ans