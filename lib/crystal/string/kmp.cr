# KMP法
#
# 文字列s[0,i-1]の接頭辞と接尾辞が最大何文字一致しているか
class Kmp
  getter s : String
  getter n : Int32
  getter dp : Array(Int64)

  def initialize(@s)
    @n = s.size
    @dp = Array.new(n + 1, -1_i64)

    j = -1_i64
    n.times do |i|
      while j >= 0 && s[i] != s[j]
        j = dp[j]
      end
      j += 1
      dp[i + 1] = j
    end
  end

  # 繰り返しを検出
  #
  # ```
  # Kmp.new("abcabc").repeat_size # => [1,1,2,3,3,3,3]
  # ```
  def repeat_size
    dp.zip(0..).map { |i, j| j - i }
  end
end
