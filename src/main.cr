# エラストテレスの篩
#
# ```
# seive(3) # => [false, false, true, true]
# ```
def sieve(n : Int32) : Array(Bool)
  Array.new(n+1, true).tap do |dp|
    dp[0] = false
    dp[1] = false
    m = Math.sqrt(n).ceil.to_i
    2.upto(m) do |i|
      next unless dp[i]
      (i*i).step(to: n, by: i) do |j|
        dp[j] = false
      end
    end
  end
end

# n以下の素数列
#
# ```
# primes(4) # => [2, 3]
# ```
def primes(n : Int32) : Array(Int32)
  sieve(n).zip(0..).select(&.first).map(&.last)
end

# bを割り切る self|b
struct Int
  def div?(b)
    b.divisible_by?(self)
  end
end

alias Factor = Set(Int64)

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
ps = primes(50).map(&.to_i64)

x = Array.new(n) do |i|
  ps.select(&.div? a[i]).to_set
end

dp = Array.new(n+1){ Set(Factor).new }
dp[0] << Factor.new

n.times do |i|
  x[i].each do |j|
    dp[i].each do |s|
      dp[i+1] << (s | Set{j})
    end
  end
end

pp dp[-1].map(&.product).min
