require "crystal/modint9"
require "crystal/fact_table"

n,m,k = gets.to_s.split.map(&.to_i64)
ind = Array.new(n, 0_i64)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  ind[v] += 1
  ind[nv] += 1
end

odd = 0_i64
even = 0_i64

n.times do |i|
  if ind[i].odd?
    odd += 1
  else
    even += 1
  end
end

ans = 0.to_m
(0..k//2).each do |i|
  ans += odd.c(i*2) * even.c(k-i*2)
end

pp ans