# dp[sの位置i, 1-origin][tのオフセットj0,1] := 編集距離 | inf
# dp[0][0] := 0
# dp[i+1][0] = dp[i][0] + (s[i] == t[i] ? 0 : 1)
# dp[i+1][1] = dp[i][0] + 1, dp[i][1] + (s[i] == t[i+1] ? 0 : 1)

INF = Int64::MAX // 4

class Problem
  @s : String

  def initialize(@s)
  end

  def solve(t : String)
    s = @s
    s, t = t, s if t.size < s.size
    return INF if (t.size - s.size).abs > 1
    
    case
    when s.size == t.size
      cnt = s.size.times.count do |i|
        s[i] != t[i]
      end
      cnt
    when s.size + 1 == t.size
      dp = make_array(Int32::MAX // 4, s.size + 1, 2)
      dp[0][0] = 0_i64
      dp[0][1] = 1_i64
      s.size.times do |i|
        dp[i+1][0] = dp[i][0] + (s[i] != t[i]).to_unsafe
        dp[i+1][1] = Math.min dp[i+1][0] + 1, dp[i][1] + (s[i] != t[i+1]).to_unsafe 
      end
      dp[-1][1]
    else
      raise "bad"
    end
  end
end

q, s = gets.to_s.split
pr = Problem.new(s)

ans = [] of Int32
(1..q.to_i).each do |i|
  t = gets.to_s
  ans << i if pr.solve(t) <= 1
end

puts ans.size
puts ans.join(" ")
