# 区間篩
#
# ```
# a = 22801763489
# b = 22801787297
# ss = SegmentSieve.new(a, b).solve
# ss.is_prime.count(true) # => 1000
# ```
class SegmentSieve
  private getter a : Int64
  private getter b : Int64
  private getter n : Int64
  getter is_prime_large : Array(Bool)
  private getter is_prime_small : Array(Bool)

  def initialize(@a, @b)
    @n = Math.isqrt(b)
    @is_prime_small = Array.new(n + 1, true)
    @is_prime_large = Array.new(@b - @a + 1, true)

    # [lo, hi)の整数に対して篩を行う
    # is_prime_large[i - a] = true <=> iが素数
    2.upto(n) do |i|
      next unless is_prime_small[i]
      (i*2).step(to: n, by: i) do |j|
        is_prime_small[j] = false
      end
      init = (a + i - 1) // i * i
      init.step(to: b, by: i) do |j|
        is_prime_large[j - a] = false
      end
    end
    self
  end

  # 素数判定
  def is_prime?(x)
    raise "範囲外です：#{a} <= #{x} <= #{b} ではありません" unless a <= x <= b
    is_prime_large[x - a]
  end
end
