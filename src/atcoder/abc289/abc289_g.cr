# Biを降順にソート
# 売上y = i * (Cx + Bi)
# {i, i * Bi}

require "crystal/cht"

n, m = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64).sort.reverse
c = gets.to_s.split.map(&.to_i64).zip(0..).sort

cht = CHT.new

n.times do |i|
  cht << {-(i+1), -(i+1)*b[i]}
end

ans = Array.new(m, -1i64)
c.each do |v, i|
  ans[i] = cht[v]
end

puts ans.map(&.-).join(" ")


