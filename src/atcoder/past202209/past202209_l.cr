# 全部で{0,1,2}個取ると決めてDP
# l = x なら r も決まる
# dp[i決め][jすでに取ったmod3] := 評価の最大

n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
b = Array.new(m) do
  gets.to_s.split.map(&.to_i64)
end
bonus = Array.new(n+1){[] of Tuple(Int64,Int32,Int32) }
b.each do |(p,q,l,r)|
  i = q.to_i.pred
  bonus[i] << {p, l.to_i, r.to_i}
end

ans = 0_i64
3.times do |tot|
  dp = make_array(Int64::MIN, n+1, 3)
  dp[0][0] = 0_i64

  bonus[0].each do |p, l, r|
    if (l + r) % 3 == tot
      dp[0][l] += p 
    end
  end
  
  n.times do |i|
    ii = i.succ
    
    3.times do |left|
      2.times do |use|
        n_left = (left + use) % 3
        chmax dp[ii][n_left], dp[i][left] + a[i] * use
      end
    end
    
    bonus[ii].each do |p, l, r|
      if (l + r) % 3 == tot
        dp[ii][l] += p 
      end
    end
  end
  chmax ans, dp[-1][tot]
end
pp ans
