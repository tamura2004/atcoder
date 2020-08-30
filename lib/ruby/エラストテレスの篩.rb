class Sieve
  EPS = 0.1
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize(n)
    @n = n
    @d = Array.new(n+1,true)
    @m = (Math.sqrt(n) + EPS).ceil
  end

  def each
    (2...m).each do |i|
      next unless d[i]
      (i*i).step(n,i) do |j|
        yield j
      end
    end
  end

  def solve
    each { d[_1] = false }
  end
  
  def [](i); d[i]; end
end

# usage
s = Sieve.new(100)
s.solve
100.times { |i| puts i if s[i] }