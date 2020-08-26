class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n,@c = gets.split.map(&:to_i)
    @x,@v = Array.new(n){ gets.split.map(&:to_i) }.transpose
    @a = v.each_with_object([0]) { |v, h| h << h[-1] + v }
    @b = v.reverse.each_with_object([0]) { |v, h| h << h[-1] + v }
  end

  def solve
    n.times do |i|
      a[i+1] -= x[i]
      b[i+1] -= c - x[n-1-i]
    end
    v1 = a.max
    v2 = b.max
    n.times do |i|
      a[i+1] -= x[i]
      b[i+1] -= c - x[n-1-i]
    end
    v3 = a.max
    v4 = b.max
    [v1+v4,v2+v3].max
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end