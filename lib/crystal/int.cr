struct Int
  def relu
    Math.max(self, 0)
  end

  def f
    1.upto(self).product(&.itself)
  end

  def div_ceil(b : self)
    raise "bad div_ceil by negative #{b}" if b < 0 && ENV["USER"] == "tamura"
    (self + b - 1) // b
  end

  def step_pow(by, to)
    PowIterator.new(self, by, to)
  end

  private class PowIterator
    include Iterator(Int64)
    getter v : Int64
    getter by : Int64
    getter to : Int64

    def initialize(@v, @by, @to)
    end

    def next
      if v <= to
        begin v ensure @v *= by end
      else
        stop
      end
    end
  end

  def of(indexable)
    indexable[self]
  end
end
