n = gets.to_s.to_i
g = Array.new(n) { Array.new(n, 0_i64) }

(n - 1).times do |v|
  gets.to_s.split.map(&.to_i64).each_with_index do |cost, dv|
    nv = v + dv + 1
    g[v][nv] = cost
    g[nv][v] = cost
  end
end

dp = Array.new(1 << n, 0_i64)
(1 << n).times do |s|
  next if s.popcount.odd?
  n.times do |y|
    next if s.bit(y) == 1
    n.times do |z|
      next if y == z
      next if s.bit(z) == 1
      t = s | (1 << y) | (1 << z)
      chmax dp[t], dp[s] + g[y][z]
    end
  end
end

pp dp.max
