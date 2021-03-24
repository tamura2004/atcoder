# メモ化再帰
#
# ```
# # アッカーマン関数
# class Ackermann < Memo(Tuple(Int32, Int32), Int32)
#   def g(m, n)
#     return n + 1 if m == 0
#     return f(m - 1, 1) if n == 0
#     f(m - 1, f(m, n - 1))
#   end
# end
# ```
class Memo(K,V)
  getter memo : Hash(K,V?)

  def initialize
    @memo = Hash(K,V?).new(nil)
  end

  def f(*key : *K) : V
    memo[key] ||= g(*key)
  end

  def f(key : K) : V
    memo[key] ||= g(key)
  end
end

# alias Key = Tuple(Int32,Int32)
# class Main < Memo(Key,Int64)
#   getter n : Int32
#   getter a : Array(Int64)
#   getter cs : Array(Int64)

#   def initialize
#     super
#     @n = gets.to_s.to_i
#     @a = gets.to_s.split.map(&.to_i64)
#     @cs = a.each_with_object([0_i64]) { |v, h| h << h[-1] + v }
#   end

#   def g(lo, hi) : V
#     return 0_i64 if hi - lo < 2
#     return a[lo] + a[lo+1] if hi - lo == 2

#     cost = (lo+1).upto(hi-1).min_of do |i|
#       g(lo, i) + g(i, hi)
#     end

#     cost + cs[hi] - cs[lo]
#   end

#   def solve
#     pp f(0, n)
#   end
# end

# Problem(Key,Int64).new.solve