class Sieve
  EPS = 0.1
  property :n,:d,:m

  @n : Int32
  @d : Array(Bool)
  @m : Int32

  def initialize(n)
    @n = n
    @d = Array.new(n+1,true)
    @m = (Math.sqrt(n) + EPS).ceil.to_i
  end

  def each
    (2...m).each do |i|
      next unless d[i]
      (i*i).step(to: n, by: i) do |j|
        yield j
      end
    end
  end

  def solve
    each do |i|
      d[i] = false
    end
    self
  end
  
  def [](i); d[i]; end

  def each_prime
    (2..n).each do |i|
      next unless d[i]
      yield i
    end
  end

  def reverse_each_prime
    n.downto(2) do |i|
      next unless d[i]
      yield i
    end
  end
end

# N = 100
# s = Sieve.new(N).solve
# count = 10
# s.reverse_each_prime do |p|
#   pp p
#   count -= 1
#   exit if count.zero?
# end

