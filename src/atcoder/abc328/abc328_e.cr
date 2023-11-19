# bit dp
INF = Int64::MAX

n, m, k = gets.to_s.split.map(&.to_i64)
g = make_array(INF, n, n)

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v -= 1
  nv -= 1
  g[v][nv] = cost
  g[nv][v] = cost
end

dp = Array.new(1 << n) { Set(Int64).new }
n.times do |v|
  dp[1 << v] << 0_i64
end

(1 << n).times do |s|
  next if dp[s].empty?

  n.times do |v|
    next if s.bit(v) == 0
    n.times do |nv|
      next if s.bit(nv) == 1
      next if g[v][nv] == INF
      dp[s].each do |old_cost|
        dp[s | (1 << nv)] << (old_cost + g[v][nv]) % k
      end
    end
  end
end

pp dp[-1].min
