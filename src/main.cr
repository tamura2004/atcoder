class State
  getter a : Int64
  getter b : Int64

  def initialize(@b)
    @a = 0_i64
  end

  def add(x)
    @a += b
    @b = x
  end

  def nobi(x)
    @b = @b * 10 + x
  end

  def to_i64
    a + b
  end
end

a = gets.to_s.chars.map(&.to_i64)
n = a.size

ans = (1<<(n-1)).times.sum do |s|
  State.new(a[0]).tap do |cnt|
    (n-1).times do |i|
      case s.bit(i)
      when 0 then cnt.add a[i+1]
      when 1 then cnt.nobi a[i+1]
      end
    end
  end.to_i64
end

pp ans



