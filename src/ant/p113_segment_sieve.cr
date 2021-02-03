# 区間篩
class SegmentSieve
  getter a : Int64
  getter b : Int64
  getter n : Int32
  getter is_prime : Array(Bool)
  getter is_prime_small : Array(Bool)

  def initialize(@a,@b)
    @n = Math.sqrt(b).to_i
    @is_prime_small = Array.new(n+1, true)
    @is_prime = Array.new(@b - @a, true)
  end

  # [lo, hi)の整数に対して篩を行う
  # is_prime[i - a] = true <=> iが素数
  def solve
    2.upto(n) do |i|
      next unless is_prime_small[i]
      (i*2).step(to: n, by: i) do |j|
        is_prime_small[j] = false
      end
      init = (a + i - 1) // i * i
      init.step(to: b, by: i) do |j|
        is_prime[j - a] = false
      end
    end
    self
  end
end

pp SegmentSieve.new(22801763489, 22801787297).
  solve.
  is_prime.
  count(true)
