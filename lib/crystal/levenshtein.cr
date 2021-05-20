# 文字列s,tの編集距離をDPで求める
def levenshtein(s : String, t : String)
  n = s.size
  m = t.size
  dp = Array.new(n+1){ Array.new(m+1){ 0 } }

  n.times do |i|
    dp[i+1][0] = i+1
  end

  m.times do |i|
    dp[0][i+1] = i+1
  end

  1.upto(n) do |i|
    1.upto(m) do |j|
      a = dp[i-1][j] + 1
      b = dp[i][j-1] + 1
      c = dp[i-1][j-1] + (s[i-1] != t[j-1]).to_unsafe
      dp[i][j] = [a,b,c].min
    end
  end
  
  # puts dp.map(&.join(" ")).join("\n")
  dp[-1][-1]
end
