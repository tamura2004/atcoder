class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n = gets.to_s.to_i
    @a = Array.new(n){ gets.to_s.to_i }.sort
  end

  def solve
    b = count
    a.reverse!
    c = count
    [b,c].max
  end

  def count
    ans = 0
    now = nil
    zigzag do |v|
      ans += (now - v).abs unless now.nil?
      now = v
    end
    ans
  end

  def zigzag
    lo = 0
    hi = n - 1
    while lo <= hi
      yield a[lo]
      yield a[hi] if lo < hi
      lo += 1
      hi -= 1
    end
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end