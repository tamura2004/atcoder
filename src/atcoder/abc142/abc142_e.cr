# さてどこから始めようか
# n <= 12という制約は、bit全探索を思わせる
# またはbitDP?
# 2 ** 12 = 4096なので
# O(M*2^n)が間に合う
# 各鍵と、空いている箱を全探索しつつDP
# dp[s空いている鍵] := 最小費用
# 鍵のbit表現をUiとして
# chmin dp[s | Ui], dp[i][s] + cost 
# dp[-1]が答え

n, m = gets.to_s.split.map(&.to_i64)

keys = Array.new(m) do
  cost, b = gets.to_s.split.map(&.to_i64)
  c = gets.to_s.split.map(&.to_i64)
  mask = c.sum{|i|1i64 << (i - 1)}
  {mask, cost}
end

INF = 1e10.to_i64
dp = make_array(INF, 1 << n)
dp[0] = 0_i64

(1<<n).times do |s|
  keys.each do |mask, cost|
    chmin dp[s | mask], dp[s] + cost
  end
end

pp dp[-1] == INF ? -1 : dp[-1]
    

