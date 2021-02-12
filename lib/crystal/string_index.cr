# 文字の次の出現場所、事前DPによるメモ化
#
# ```
# m = StringIndex.new("abcdabcd")
# m['b']    # => 1
# m['b', 1] # => 1
# m['b', 2] # => 5
# m['b', 6] # => nil
# ```
class StringIndex
  getter a : String
  getter dp : Hash(Char, Array(Int32?))

  def initialize(@a : String)
    n = a.size
    @dp = Hash(Char, Array(Int32?)).new { |h, k| h[k] = Array(Int32?).new(n + 1, nil) }
    (n - 1).downto(0) do |i|
      dp.keys.each do |key|
        dp[key][i] = dp[key][i + 1]
      end
      dp[a[i]][i] = i
    end
  end

  def [](c : Char, offset : Int32 = 0)
    dp[c][offset]
  end
end