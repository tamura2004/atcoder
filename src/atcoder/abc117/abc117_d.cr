enum S
  None
  Edge
  Free
end

m, a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)
# pp (0..a).max_of{|x|b.map{|v|v^x}.sum}
quit b.sum if a.zero?

n = Math.max(Math.ilogb(a), Math.ilogb(b.max)) + 1
a = sprintf("%0#{n}b", a).chars.map(&.to_i)

cnt = Array.new(n, 0_i64)
b.each do |v|
  n.times do |i|
    cnt[i] += v.bit(i)
  end
end
cnt.reverse!

dp = Array.new(n+1) do
  Hash(S,Int64).new(-1_i64)
end
dp[0][S::None] = 0_i64

n.times do |i|
  S.each do |j|
    next if dp[i][j] == -1_i64
    2.times do |d|
      next if !j.free? && d > a[i]
      jj = S::Free
      jj = S::Edge if !j.free? && d == 1 # 初めて置いた
      jj = S::Edge if j.edge? && d == a[i]
      jj = S::None if j.none? && a[i] == 0 # 置かない
      v = cnt[i]
      v = m - v if d == 1
      chmax dp[i+1][jj], dp[i][j] * 2 + v
    end
  end
end

pp dp[-1].values.select(&.!= -1).max

