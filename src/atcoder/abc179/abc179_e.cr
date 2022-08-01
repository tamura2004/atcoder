# ダブリング
# 位置のダブリング
# 累積和のダブリング

n, x, m = gets.to_s.split.map(&.to_i64)
D = 34

nex = Array.new(D) { Array.new(m, 0_i64) }
sum = Array.new(D) { Array.new(m, 0_i64) }

m.times do |v|
  nv = v ** 2 % m
  nex[0][v] = nv # 次の位置
  sum[0][v] = v  # 和
end

(1...D).each do |i|
  m.times do |v|
    nv = nex[i - 1][v]
    nex[i][v] = nex[i - 1][nv]
    sum[i][v] = sum[i - 1][v] + sum[i - 1][nv]
  end
end

ans = 0_i64
D.times do |i|
  next if n.bit(i).zero?

  ans += sum[i][x]
  x = nex[i][x]
end

pp ans
