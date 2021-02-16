# メモ化再帰のひな型
alias Key = Tuple(Int64,Int64)
alias Memo = Hash(Key,Int64?)

class Problem
  getter n : Int64
  getter x : Int64
  getter a : Array(Int64)
  getter memo : Memo

  def initialize(@n,@x,@a)
    @memo = Memo.new { |h, k| h[k] = nil }
  end

  def solve
    f(0_i64, x)
  end

  def f(i, x)
    memo[{i,x}] ||= g(i,x)
  end

  def g(i, x)
    return 1_i64 if i == n - 1
    y = a[i + 1]
    z = x % y
    return f(i + 1, x - z) if z == 0
    f(i + 1, x - z) + f(i + 1, x - z + y)
  end
end

# class Problem
#   getter n : Int32
#   getter a : Array(Int64)
#   getter dp : Array(Array(Int64?))

#   def initialize
#     @n = gets.to_s.to_i
#     @a = gets.to_s.split.map { |v| v.to_i64 }
#     @dp = Array.new(n) { Array(Int64?).new(n, nil) }
#     n.times { |i| dp[i][i] = a[i] }
#   end

#   def solve
#     puts f(0, n-1)
#   end

#   def g(lo, hi)
#     dp[lo][hi] ||= f(lo, hi)
#   end

#   def f(lo, hi)
#     return a[lo] if lo == hi
#     dp[lo][hi] = Math.max(
#       a[lo] - f(lo + 1, hi),
#       a[hi] - f(lo, hi - 1)
#     )
#   end
# end

# Problem.new.solve