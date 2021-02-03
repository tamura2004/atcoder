class Sieve
  getter n : Int32
  getter is_prime : Array(Bool)

  def initialize(@n)
    @is_prime = Array.new(n + 1) { true }
    is_prime[0] = false
    is_prime[1] = false
  end

  def solve
    m = Math.sqrt(n).to_i
    (2..m).each do |i|
      next unless is_prime[i]
      (i*i).step(to: n, by: i) do |j|
        is_prime[j] = false
      end
    end
    self
  end

  def each_prime
    m = Math.sqrt(n).to_i
    (2..m).each do |i|
      next unless is_prime[i]
      yield i
      (i*i).step(to: n, by: i) do |j|
        is_prime[j] = false
      end
    end
  end

  forward_missing_to @is_prime
end

n = 1000000
s = Sieve.new(n)
s.solve
pp s.is_prime.count(true)

