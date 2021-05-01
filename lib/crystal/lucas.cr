# Lucasの定理
#
# 任意の素数pと非負整数n,mに対して
# 二項係数 nCmを高速に求める
# 計算量：前処理O(p^2)
# 計算量：クエリO(log p n)
#
# ```
# lc = Lucas.new(3)
# lc.combi(26,13) # => 2
# # 26C13 -> 10400600 % 3 == 2
# ```
class Lucas
  getter p : Int32
  getter dp : Array(Array(Int32))

  def initialize(@p)
    @dp = Array.new(p){ Array.new(p, 0) }
    dp[0][0] = 1
    1.upto(p-1) do |n|
      p.times do |m|
        dp[n][m] = dp[n-1][m] + dp[n-1][m-1]
        dp[n][m] %= p
      end
    end
  end

  def combi(n, m)
    ans = 1
    while n > 0 || m > 0
      n, nr = n.divmod(p)
      m, mr = m.divmod(p)
      ans *= dp[nr][mr]
      ans %= p
    end
    return ans
  end
end