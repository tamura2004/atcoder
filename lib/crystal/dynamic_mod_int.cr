# 動的modint
# 加減乗除は自前で
struct DynamicModInt
  getter mod : Int64
  getter fact : Array(Int64)
  getter finv : Array(Int64)

  def initialize(@mod)
    @fact = [1_i64]
    (1...mod).each{|i| @fact << @fact.last * i % mod }
    @finv = [inv(fact.last)]
    (1...mod).each { |i| @finv << @finv.last * (mod - i) % mod }
    @finv.reverse!
  end

  def c(n, k)
    return 0_i64 if mod < k
    return 0_i64 if n < k
    return 0_i64 if k < 0
    fact[n] * finv[n-k] % mod * finv[k] % mod
  end

  def pow(a, b)
    a = a.to_i64 % mod
    ans = 1_i64
    while b > 0
      if b.odd?
        ans *= a
        ans %= mod
      end
      b //= 2
      a *= a
      a %= mod
    end
    ans
  end

  def inv(a)
    pow(a, mod - 2)
  end
end