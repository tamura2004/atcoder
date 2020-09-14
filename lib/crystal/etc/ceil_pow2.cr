# @param n `0 <= n`
# @return minimum non-negative `x` s.t. `n <= 2**x`
def ceil_pow2(n : Int) : Int32
  raise ArgumentError.new("n = #{n} must be zero or positive") if n < 0
  (0..).find(-1) do |x|
    n < (1 << x)
  end
end
