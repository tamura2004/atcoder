# dp
# dp[t][x] := 最大値
# 遷移
# dp[t][x] += max(t-1,x-1)x,x+1 
# require "crystal/indexable"

TMAX = 100_000

n = gets.to_s.to_i
txa = Array.new(n) do
  t,x,a = gets.to_s.split.map(&.to_i64)
  {t,x,a}
end

dp = make_array(-1_i64, TMAX + 1, 5)
dp[0][0] = 0_i64

txa.each do |t,x,a|
  dp[t][x] = a if x <= t
end

(1..TMAX).each do |t|
  5.times do |x|
    pre = ({-1,0,1}).max_of do |dx|
      px = x + dx
      next -1_i64 if px < 0 || 5 <= px 
      dp[t-1][px]
    end
    next if pre == -1
    if dp[t][x] == -1
      dp[t][x] = pre
    else
      dp[t][x] += pre
    end
  end
end

# pp dp.first(10)
pp dp[-1].max
