class LazySegmentTree
  attr_reader :n, :r, :x, :a

  def fxx(x, y)
    x < y ? x : y
  end

  def x_unit
    1 << 60
  end

  def faa(a, b)
    b ? b : a
  end

  def a_unit
    nil
  end

  def fxa(x, a)
    a ? a : x
  end

  def initialize(vs)
    @n = 1
    @r = 0

    while @n < vs.size
      @n <<= 1
      @r += 1
    end

    @x = Array.new(n * 2, x_unit)
    @a = Array.new(n * 2, a_unit)

    vs.each_with_index do |v, i|
      x[i + n] = v
    end

    (1...n).reverse_each do |i|
      lo = i << 1
      hi = lo | 1
      x[i] = fxx x[lo], x[hi]
    end
  end

  def set(i, v)
    i += n
    propagate_down(i)
    x[i] = v
    a[i] = a_unit
    recalc_up(i)
  end

  def fold(lo, hi)
    lo += n
    hi += n

    lo0 = lo / (lo & -lo)
    hi0 = hi / (hi & -hi) - 1

    propagate_down(lo0)
    propagate_down(hi0)

    left = right = x_unit

    while lo < hi
      if lo.odd?
        left = fxx left, fxa(x[lo], a[lo])
        lo += 1
      end

      if hi.odd?
        hi -= 1
        right = fxx fxa(x[hi], a[hi]), right
      end

      lo >>= 1
      hi >>= 1
    end

    fxx left, right
  end

  def update(lo, hi, v)
    lo += n
    hi += n

    lo0 = lo / (lo & -lo)
    hi0 = hi / (hi & -hi) - 1

    propagate_down(lo0)
    propagate_down(hi0)

    while lo < hi
      if lo.odd?
        a[lo] = faa a[lo], v
        lo += 1
      end

      if hi.odd?
        hi -= 1
        a[hi] = faa a[hi], v
      end

      lo >>= 1
      hi >>= 1
    end

    recalc_up(lo0)
    recalc_up(hi0)
  end

  # 上から下に作用を伝播
  def propagate_down(i)
    return if i.zero?
    (1..Math.log2(i).to_i).each do |n|
      j = i >> n
      # j = 1
      # (0...r).reverse_each do |k|
      lo = j << 1
      hi = lo | 1

      a[lo] = faa a[lo], a[j]
      a[hi] = faa a[hi], a[j]
      x[j] = fxa x[j], a[j]
      a[j] = a_unit

      # j = j << 1 | i[k]
    end
  end

  # 下から上に再計算
  def recalc_up(i)
    while i > 1
      i >>= 1
      lo = i << 1
      hi = lo | 1
      x[i] = fxx fxa(x[lo], a[lo]), fxa(x[hi], a[hi])
    end
  end
end

n, q = gets.split.map(&:to_i)
st = LazySegmentTree.new(Array.new(n, (1 << 31) - 1))
q.times do |i|
  cmd, x, y, z = gets.split.map(&:to_i) + [0]
  case cmd
  when 0
    st.update(x, y + 1, z)
  when 1
    puts st.fold(x, y + 1)
  end
end
