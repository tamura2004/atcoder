# @param n `1 <= n`
# @return minimum non-negative `x` s.t. `(n & (1 << x)) != 0`
def bsf(n : Int) : Int32
  raise ArgumentError.new("n = #{n} must be positive") if n < 1
  (0..).find do |x|
    (n >> x) & 1 == 1
  end
end
