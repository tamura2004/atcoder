class LazySegmentTree
  attr_reader :n, :r, :a, :b

  UNIT_X = (1 << 31) - 1
  UNIT_A = nil

  def min(a, b)
    a < b ? a : b
  end

  def initialize(values)
    @n = 1
    @r = 0
    while @n < values.size
      @n <<= 1
      @r += 1
    end

    @a = Array.new(n << 1, UNIT_X)
    @b = Array.new(n << 1, UNIT_A)

    values.each_with_index do |v, i|
      a[i + n] = v
    end

    (1...n).reverse_each do |i|
      lo = i << 1
      hi = lo | 1

      a[i] = min a[lo], a[hi]
    end
  end
end
