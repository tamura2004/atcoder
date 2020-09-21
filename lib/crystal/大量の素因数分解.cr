class Sieve
  EPS = 0.1
  property :n, :d, :m

  @n : Int32
  @d : Array(Int32)
  @m : Int32

  def initialize(n)
    @n = n
    @d = Array.new(n + 1) { |i| i }
    @m = (Math.sqrt(n) + EPS).ceil.to_i
  end

  def each
    (2..m).each do |i|
      next unless d[i] == i
      (i*i).step(to: n, by: i) do |j|
        yield i, j
      end
    end
  end

  def solve
    each do |i, j|
      d[j] = i if d[j] == j
    end
    self
  end

  def [](i)
    d[i]
  end

  def prime_division(x, ans : Hash(Int32, Int32))
    while x > 1
      ans[d[x]] += 1
      x //= d[x]
    end
  end
end

# MOD = 10**9+7
# n = gets.to_s.to_i
# s = Sieve.new(1005).solve
# h = Hash(Int32, Int32).new(0)
# n.downto(2) do |i|
#   s.prime_division(i, h)
# end
# pp h.values.reduce(1_i64) { |acc, v| acc * (v + 1) % MOD }
