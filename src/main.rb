class Gcd
  attr_accessor :ans
  def initialize
    @ans = 0
  end

  def solve(a,b)
    if b == 0
      return self
    elsif a < b
      return solve(b,a)
    else
      q,r = a.divmod(b)
      @ans += b * q
      return solve(b, r)
    end
  end
end

n,x = gets.split.map &:to_i
puts Gcd.new.solve(n-x,x).ans * 3