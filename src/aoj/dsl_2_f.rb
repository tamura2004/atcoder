class LazySegmentTree
  attr_reader :x, :a, :n, :r, :x_unit, :a_unit, :fxx, :fxa, :faa

  def initialize(fxx, fxa, faa, x_unit, a_unit, values)
    @fxx = fxx
    @fxa = fxa
    @faa = faa
    @x_unit = x_unit
    @a_unit = a_unit

    @n = 1
    @r = 0
    while @n < values.size
      @n <<= 1
      @r += 1
    end

    @x = Array.new(n << 1, x_unit)
    @a = Array.new(n << 1, a_unit)

    values.each_with_index do |v, i|
      x[i + n] = v
    end

    (1...n).reverse_each do |i|
      x[i] = fxx.call x[i << 1], x[i << 1 | 1]
    end
  end

  def set(i, y)
    i += n
    propagate(i)
    x[i] = y
    a[i] = a_unit
    recalc(i)
  end

  def []=(i, y)
    set(i, y)
  end

  def fold(i, j)
    i += n
    j += n

    i0 = pa(i)
    j0 = pa(j) - 1

    propagate(i0)
    propagate(j0)

    left = x_unit
    right = x_unit
    while i < j
      if i.odd?
        left = fxx.call left, eval(i)
        i += 1
      end
      if j.odd?
        j -= 1
        right = fxx.call eval(j), right
      end
      i >>= 1
      j >>= 1
    end
    fxx.call left, right
  end

  def [](r)
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    fold(lo, hi)
  end

  def [](i)
    j = i.to_i
    fold(j, j + 1)
  end

  def update(i, j, b)
    i += n
    j += n

    i0 = pa(i)
    j0 = pa(j) - 1

    propagate(i0)
    propagate(j0)

    while i < j
      if i.odd?
        a[i] = faa.call a[i], b
        i += 1
      end
      if j.odd?
        j -= 1
        a[j] = faa.call a[j], b
      end
      i >>= 1
      j >>= 1
    end

    recalc(i0)
    recalc(j0)
  end

  def []=(r, b)
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    update(lo, hi, b)
  end

  def recalc(i)
    path(i >> 1).each do |i|
      x[i] = fxx.call eval(i << 1), eval(i << 1 | 1)
    end
  end

  def propagate(j)
    return if j.zero?

    path(j).reverse_each do |i|
      next if a[i] == a_unit
      lo = i << 1
      hi = lo | 1
      a[lo] = faa.call a[lo], a[i]
      a[hi] = faa.call a[hi], a[i]
      x[i] = fxa.call x[i], a[i]
      a[i] = a_unit
    end
  end

  def path(i)
    return [] if i <= 0
    ans = [i]
    while i > 0
      ans << (i >>= 1)
    end
    ans
  end

  def eval(i)
    fxa.call x[i], a[i]
  end

  def pa(i)
    i / (i & -i)
  end
end

n, q = gets.split.map(&:to_i)

fxx = ->(x, y) { x < y ? x : y }
fxa = ->(x, a) { a ? a : x }
faa = ->(a, b) { b ? b : a }
x_unit = 2 ** 31 - 1
a_unit = nil
values = Array.new(n, 2 ** 31 - 1)
st = LazySegmentTree.new(fxx, fxa, faa, x_unit, a_unit, values)
q.times do |i|
  cmd, x, y, z = gets.split.map(&:to_i) + [0]
  case cmd
  when 0
    st.update(x, y + 1, z)
  when 1
    puts st.fold(x, y + 1)
  end
end
