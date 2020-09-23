class Factor
  getter counter : Hash(Int32, Int32)
  forward_missing_to counter
  def_equals counter

  def initialize
    @counter = Hash(Int32, Int32).new(0)
  end

  def initialize(@counter)
  end

  # 約数の個数
  def num_of_divisors
    values.reduce(1) do |acc, v|
      acc * (v + 1)
    end
  end

  def to_i
  end

  def gcd(other : self)
  end

  def lcm(other : self)
  end
end

class Prime
  extend Iterator(Int64)

  MAX = 3_000_000

  @@is_prime = Array(Bool).new(MAX + 1, true)
  @@min_div = Array(Int32).new(MAX + 1, &.itself)
  @@pt = 0_i64

  def self.sieve
    @@is_prime[0] = false
    @@is_prime[1] = false
    m = Math.sqrt(MAX).to_i
    (2..m).each do |i|
      next if !@@is_prime[i]
      (i*i).step(to: MAX, by: i) do |j|
        @@is_prime[j] = false
        @@min_div[j] = i if @@min_div[j] == j
      end
    end
  end

  def self.prime?(n : Int) : Bool
    sieve if @@is_prime[0]
    @@is_prime[n]
  end

  def self.next(maxi = MAX)
    @@pt += 1 if @@pt < MAX
    until @@pt > MAX || prime?(@@pt)
      @@pt += 1
    end
    @@pt > MAX ? stop : @@pt
  end

  def self.rewind
    @@pt = 0_i64
  end

  def self.prime_division(x : Int) : Factor
    sieve if @@is_prime[0]
    Factor.new.tap do |ans|
      while x > 1
        ans[@@min_div[x]] += 1
        x //= @@min_div[x]
      end
    end
  end

  def self.division(x : Int) : Factor
    prime_division(x)
  end

  def self.prime_division(*a) : Array(Factor)
    sieve if @@is_prime[0]
    ans = [] of Factor
    a.each do |x|
      cnt = Factor.new
      while x > 1
        cnt[@@min_div[x]] += 1
        x //= @@min_div[x]
      end
      ans << cnt
    end
    ans
  end

  def self.division(*a) : Array(Factor)
    prime_division(*a)
  end

  def self.prime_division_conv(*a) : Factor
    sieve if @@is_prime[0]
    ans = Factor.new
    a.each do |x|
      while x > 1
        ans[@@min_div[x]] += 1
        x //= @@min_div[x]
      end
    end
    ans
  end

  def self.division_conv(*a) : Factor
    prime_division_conv(*a)
  end
end
