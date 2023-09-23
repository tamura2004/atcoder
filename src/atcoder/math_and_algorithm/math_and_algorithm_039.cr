require "crystal/dual_segment_tree"

n, q = gets.to_s.split.map(&.to_i64)
st = n.to_st_sum

q.times do
  l, r, x = gets.to_s.split.map(&.to_i64)
  l -= 1
  r -= 1
  st[l..r] = x
end

ans = (0...n - 1).map do |i|
  "=><"[st[i] <=> st[i + 1]]
end.join

puts ans
