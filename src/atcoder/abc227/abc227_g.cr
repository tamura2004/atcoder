class Sieve
  getter n : Int64
  getter primes : Array(Int64)
  getter is_prime : Array(Bool)

  def initialize(n)
    @n = n.to_i64
    @primes = [] of Int64
    @is_prime = Array.new(n+1, true)
    is_prime[0] = false
    is_prime[1] = false
  end

  def solve
    (2i64..n).each do |i|
      next unless is_prime[i]
      primes << i
      (i*2).step(by: i, to: n) do |j|
        is_prime[j] = false
      end
    end
    primes
  end
end

class PrimeFactor
  getter lo : Int64
  getter hi : Int64
  getter n : Int64
  getter val : Array(Int64)
  getter factor : Array(Array(Int64))

  def initialize(lo, hi)
    @lo = lo.to_i64
    @hi = hi.to_i64
    @n = @hi - @lo + 1
    @val = Array.new(n) { |i| @lo + i }
    @factor = Array.new(n) { [] of Int64 }
  end

  def solve
    maxi = Math.sqrt(hi).to_i64.succ
    Sieve.new(maxi).solve.each do |i|
      offset = (lo + i - 1) // i * i - lo
      offset.step(by: i, to: hi - lo) do |j|
        while val[j].divisible_by?(i)
          val[j] //= i
          factor[j] << i
        end
      end
    end
    val.each_with_index do |v, i|
      factor[i] << v.to_i64 if v != 1
    end
    factor
  end
end

MOD = 998_244_353_i64
n, k = gets.to_s.split.map(&.to_i64)
maxi = Math.max(Math.sqrt(n).to_i64.succ, k)

cnt = Hash(Int64,Int64).new(0_i64)
PrimeFactor.new(n-k+1,n).solve.each do |factor|
  factor.each do |i|
    cnt[i] += 1
  end
end

PrimeFactor.new(1,k).solve.each do |factor|
  factor.each do |i|
    cnt[i] -= 1
  end
end

ans = 1_i64
cnt.values.each do |i|
  ans *= i + 1
  ans %= MOD
end
pp ans
