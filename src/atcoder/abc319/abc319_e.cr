# dp
# 状態として、今、2*2*2*3*5*7で割ったあまりは？==840
# dp[0][0...840] = 高橋君の家を出発する時刻

n, x, y = gets.to_s.split.map(&.to_i64)
pt = Array.new(n - 1) do
  p, t = gets.to_s.split.map(&.to_i64)
  {p, t}
end

dp = Array.new(840) do |root|
  now = x + root

  pt.each do |p, t|
    if now % p == 0
      now += t
    else
      now += (p - (now % p)) + t
    end
  end

  now + y - root
end

qs = gets.to_s.to_i64
qs.times do
  q = gets.to_s.to_i64
  pp q + dp[q % 840]
end
