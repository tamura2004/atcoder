require "crystal/modint9"

MAX = 500_000i64

class Seive
  getter min_factor : Array(Int64)
  getter moebius : Array(Int64)
  getter is_prime : Array(Bool)

  def initialize
    @min_factor = Array.new(MAX+1, &.itself.to_i64)
    @moebius = Array.new(MAX+1, 1_i64)
    @is_prime = Array.new(MAX+1, true)

    min_factor[1] = 1
    moebius[1] = 1
    is_prime[1] = false

    (2_i64..MAX).each do |i|
      next unless is_prime[i]
      moebius[i] = -1_i64
      (i * 2).step(by: i, to: MAX) do |j|
        is_prime[j] = false
        min_factor[j] = i
        moebius[j] *= (j // i).divisible_by?(i) ? 0_i64 : -1_i64
      end
    end
  end
end

def factors(n)
  m = 1_i64
  ans = [] of Int64
  while m * m <= n
    if n.divisible_by?(m)
      ans << m
      ans << n // m unless m * m == n
    end
    m += 1
  end
  ans
end

sv = Seive.new

n = gets.to_s.to_i64
s = gets.to_s.chars.map(&.==('#').to_unsafe)

query = -> (m : Int64) do
  cnt = Array.new(m, 1_i64)
  s.each_with_index do |v, i|
    cnt[i % m] *= v
  end
  2.to_m ** cnt.sum
end

a = Hash(Int64,ModInt).new
factors(n).each do |d|
  next if n == d
  a[d] = query.call(d)
end

b = Hash(Int64,ModInt).new
factors(n).each do |m|
  next if n == m
  ans = 0.to_m
  factors(m).each do |d|
    ans += a[d] * sv.moebius[m//d]
  end
  b[m] = ans
end

puts b.values.sum
