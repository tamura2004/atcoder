# 複数のクエリの素因数分解を高速に処理する
class SmallestPrimeFactor
  EPS = 0.1
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize(n)
    @n = n
    @d = Array.new(n+1,&:itself)
    @m = (Math.sqrt(n) + EPS).ceil
    each { |i,j| d[j] = i }
  end

  def each
    (2...m).each do |i|
      next unless d[i] == i
      (i*i).step(n,i) do |j|
        yield i,j
      end
    end
  end
  
  def prime_division(n)
    ans = Hash.new(0)
    while n > 1
      ans[d[n]] += 1
      n /= d[n]
    end
    ans
  end
end

# usage
# N = 20
# s = SmallestPrimeFactor.new(N)
# (2..N).each do |i|
#   pp s.prime_division(i)
# end
