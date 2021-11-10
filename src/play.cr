private class FactorIterator(T)
  include Iterator(T)
  getter n : T
  getter i : Int32
  getter factors : T

  def initialize(@n)
    @i = 0
    @factors = [] of T
    m = T.new Math.sqrt(n)
    T.new(1).upto(m) do |i|
      next unless n.divisible_by?(i)
      factors << i
      factors << n // i if i * i != n
    end
  end

  def next
    if i < factors.size
      begin factors[i] ensure @i += 1 end
    else
      stop
    end
  end
end

struct Int
  def factors
    ft = FactorIterator(Int32).new(72)
    ft.each do |i|
      pp i
    end
  end
end

