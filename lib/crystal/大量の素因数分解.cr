class Sieve
  EPS = 0.1
  property :n,:d,:m

  @n : Int32
  @d : Array(Int32)
  @m : Int32

  def initialize(n)
    @n = n
    @d = Array.new(n+1) { |i| i }
    @m = (Math.sqrt(n) + EPS).ceil.to_i
  end

  def each
    (2..m).each do |i|
      next unless d[i] == i
      (i*i).step(to: n, by: i) do |j|
        yield i,j
      end
    end
  end

  def solve
    each do |i,j|
      d[j] = i if d[j] == j
    end
    self
  end
  
  def [](i); d[i]; end

  def prime_division(x)
    ans = Set(Int32).new
    while x > 1
      ans << d[x]
      x //= d[x]
    end
    ans
  end
end

# class Problem
#   property :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z

#   @n : Int32
#   @a : Array(Int32)
#   @s : Sieve

#   def initialize
#     @n = gets.to_s.to_i
#     @a = gets.to_s.split.map(&.to_i)
#     @s = Sieve.new(1_000_000).solve
#   end

#   def setwise?
#     a.reduce { |acc,i| acc.gcd(i) } == 1
#   end

#   def pairwise?
#     cnt = Set(Int32).new
#     a.each do |i|
#       s.prime_division(i).each do |j|
#         return false if cnt === j
#         cnt << j
#       end
#     end
#     return true
#   end

#   def solve
#     return "not coprime" if !setwise?
#     return "pairwise coprime" if pairwise?
#     "setwise coprime"
#   end

#   def show(ans)
#     puts ans
#   end
# end

# Problem.new.try do |me|
#   me.show(me.solve)
# end

