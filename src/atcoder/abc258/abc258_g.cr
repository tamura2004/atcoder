require "crystal/indexable"

n, x, m = gets.to_s.split.map(&.to_i64)

nex = Array.new(40) { Array.new(m, 0_i64) }
sum = Array.new(40) { Array.new(m, 0_i64) }

# 初期値
m.times do |v|
  nv = v ** 2 % m
  nex[0][v] = nv
  sum[0][v] = v
end

# ダブリング準備
(1...40).each do |i|
  m.times do |v|
    nex[i][v] = nex[i-1][nex[i-1][v]]
    sum[i][v] = sum[i-1][v] + sum[i-1][nex[i-1][v]]
  end
end

ans = 0_i64
40.times do |i|
  next if n.bit(i) == 0

  ans += sum[i][x]
  x = nex[i][x]
end

pp ans