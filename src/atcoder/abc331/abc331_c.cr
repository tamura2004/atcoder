require "crystal/st"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

st = Array.new(1_000_002, 0_i64).to_st_sum
ans = Array.new(n, 0_i64)

a.zip(0..).sort.reverse.each do |v, i|
  ans[i] = st[v+1..]
  st[v] += v
end

puts ans.join(" ")