require "crystal/problem"

# 最長共通部分列問題
#
# 二つの文字列*s*と*t*の共通部分文字列の
# 長さの最大値を求める。
#
# ```
# input = <<-EOS
# 4 4
# abcd
# becd
# EOS
# LCS.read(input).solve # => 3
# ```
class LCS < Problem
  getter n : Int32
  getter m : Int32
  getter s : String
  getter t : String

  def self.read(io : IO)
    n,m = io.gets.to_s.split.map(&.to_i)
    s = io.gets.to_s
    t = io.gets.to_s
    new(n,m,s,t)
  end

  def initialize(@n,@m,@s,@t)
  end

  # 動的計画法で共通部分文字列の長さの最大値を求める
  #
  # dp[sの末尾位置i][tの末尾位置j] := そこまでのLCSの長さ
  # dp[i+1, j+1] =
  #   Si == Ti  | dp[i,j] + 1
  #   otherwise | max dp[i,j+1], dp[i+1,j]
  def solve
    dp = Array.new(n + 1) { Array.new(m + 1, 0_i64) }
    n.times do |i|
      m.times do |j|
        if s[i] == t[j]
          dp[i + 1][j + 1] = dp[i][j] + 1
        else
          dp[i + 1][j + 1] = Math.max dp[i + 1][j], dp[i][j + 1]
        end
      end
    end
    return dp[-1][-1]
  end
end
