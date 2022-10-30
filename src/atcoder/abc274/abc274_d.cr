# 部分和問題
def solve(n, a, goal, flag)
  # dp[iまで決め][位置j] := bool
  # 位置jは+10^4のオフセット
  dp = make_array(false, n+1, 20000)
  dp[0][10000] = true

  n.times do |i|
    20000.times do |j|
      2.times do |k| # k = 0 引く, 1 足す
        next if flag && i.zero? && k.zero?
        jj = j + a[i] * (k.zero? ? -1 : 1)
        next unless 0 <= jj < 20000
        dp[i+1][jj] ||= dp[i][j]
      end
    end
  end

  dp[-1][goal+10000]
end

n,x,y = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

odd = n.times.select(&.odd?).map{|i|a[i]}.to_a
even = n.times.select(&.even?).map{|i|a[i]}.to_a

ans1 = solve(even.size, even, x, true)
ans2 = solve(odd.size, odd, y, false)

puts ans1 && ans2 ? "Yes" : "No"