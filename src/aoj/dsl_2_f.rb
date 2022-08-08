class LazySegmentTree
  attr_reader :n, :x, :a, :fxx, :fxa, :faa, :x_unit, :a_unit

  def initialize(values, fxx, fxa, faa, x_unit, a_unit)
    @fxx = fxx
    @fxa = fxa
    @faa = faa
    @x_unit = x_unit
    @a_unit = a_unit

    @n = 1
    while n < values.size
      @n <<= 1
    end

    @x = Array.new(n << 1, x_unit)
    @a = Array.new(n << 1, a_unit)

    (1...n).reverse_each do |i|
      lo = i << 1
      hi = lo | 1
      x[i] = fxx.call x[lo], x[hi]
    end
  end

  def path(i)
    return [] if i < 1
    ans = [i]
    while i > 1
      i >>= 1
      ans << i
    end
    ans
  end

  def eval(i)
    return if i < 1
    return x[i] if a[i] == a_unit

    x[i] = fxa.call x[i], a[i]

    if i < n
      lo = i << 1
      hi = lo | 1
      a[lo] = faa.call a[lo], a[i]
      a[hi] = faa.call a[hi], a[i]
    end

    a[i] = a_unit
    x[i]
  end

  def recalc(j)
    return if j < 1
    # return if n <= i
    path(j).reverse_each do |i|
      next if n <= i
      lo = i << 1
      hi = lo | 1
      x[i] = fxx.call(fxa.call(x[lo], a[lo]), fxa.call(x[hi], a[hi]))
    end
  end

  def propagete(j)
    path(j).reverse_each do |i|
      eval(i)
    end
  end

  def get(i)
    i += n
    propagete(i)
    recalc_up(i)
    x[i]
  end

  def set(i, v)
    i += n
    propagete(i)
    eval(i)
    x[i] = v
    recalc_up(i)
  end

  def update(lo, hi, v)
    lo += n
    hi += n

    lo_head = lo / (lo & -lo)
    hi_head = hi / (hi & -hi) - 1

    propagete(lo_head)
    propagete(hi_head)

    while lo < hi
      if lo.odd?
        a[lo] = faa.call a[lo], v
        lo += 1
      end

      if hi.odd?
        hi -= 1
        a[hi] = faa.call a[hi], v
      end

      lo >>= 1
      hi >>= 1
    end

    recalc(lo_head)
    recalc(hi_head)
  end

  def fold(lo, hi)
    lo += n
    hi += n

    lo_head = lo / (lo & -lo)
    hi_head = hi / (hi & -hi) - 1

    propagete(lo_head)
    propagete(hi_head)

    left = right = x_unit

    while lo < hi
      if lo.odd?
        left = fxx.call left, fxa.call(x[lo], a[lo])
        lo += 1
      end

      if hi.odd?
        hi -= 1
        right = fxx.call fxa.call(x[hi], a[hi]), right
      end

      lo >>= 1
      hi >>= 1
    end

    fxx.call left, right
  end

  def debug
    path(n).reverse.each_with_index do |i, h|
      xs = x[i, 1 << h]
      as = a[i, 1 << h]
      puts xs.zip(as).map { |x, a| "#{x}/#{a}" }.join(" ")
    end
    puts "=" * 20
  end
end

n, q = gets.split.map(&:to_i)

fxx = ->(x, y) { x < y ? x : y }
fxa = ->(x, a) { a ? a : x }
faa = ->(a, b) { b ? b : a }
x_unit = (1 << 31) - 1
a_unit = nil
values = Array.new(n, x_unit)

st = LazySegmentTree.new(values, fxx, fxa, faa, x_unit, a_unit)

q.times do
  cmd, lo, hi, v = gets.split.map(&:to_i) + [0]
  case cmd
  when 0
    st.update(lo, hi + 1, v)
  when 1
    puts st.fold(lo, hi + 1)
  end
end
