# n, d, a = gets.to_s.split.map(&.to_i64)
# x, h = Array.new(n){gets.to_s.split.map(&.to_i64)}.sort.transpose

# heat = 0_i64
# ans = 0_i64
# lo = hi = 0
# while lo < n && hi < n  
#   while hi < n && x[hi] <= x[lo] + d * 2
#     h[hi] += heat
#     hi += 1
#   end

#   cnt = divceil(h[lo] - heat, a)
#   ans += cnt
#   heat += cnt * a

#   while lo < hi && h[lo] <= heat
#     lo += 1
#   end
# end

# pp ans

require "crystal/segment_tree"

st = ST.sum(10)
st[3] += 1
st[7] -= 1
10.times do |i|
  pp st[..i]
end
