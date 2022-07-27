# 遅延評価セグメント木
class LazySegmentTree(X, A)
  alias I = Int::Signed

  getter fxx : Proc(X, X, X)
  getter fxa : Proc(X, A, X)
  getter faa : Proc(A, A, A)
  getter x_unit : X
  getter a_unit : A
  getter n : I
  getter x : Array(X)
  getter a : Array(A)

  # 区間更新、区間最小
  def self.range_update_range_min(n : I)
    values = Array(X).new(n){ X::MAX }
    range_update_range_min(values)
  end

  # 区間更新、区間最小
  def self.range_update_range_min(n : I, init : X)
    values = Array(X).new(n){ init }
    range_update_range_min(values)
  end

  # 区間更新、区間最小
  def self.range_update_range_min(values : Array(X))
    new(
      Proc(X, X, X).new { |x, y| Math.min x, y },
      Proc(X, A, X).new { |x, a| Math.min x, a },
      Proc(A, A, A).new { |a, b| Math.min a, b },
      X::MAX,
      A::MAX,
      values,
    )
  end

  # 区間更新、区間最小
  def self.range_update_range_max(n : I)
    values = Array(X).new(n){ X::MIN }
    range_update_range_max(values)
  end

  # 区間更新、区間最小
  def self.range_update_range_max(n : I, init : X)
    values = Array(X).new(n){ init }
    range_update_range_max(values)
  end

  # 区間更新、区間最大
  def self.range_update_range_max(values : Array(X))
    new(
      Proc(X, X, X).new { |x, y| Math.max x, y },
      Proc(X, A, X).new { |x, a| Math.max x, a },
      Proc(A, A, A).new { |a, b| Math.max a, b },
      X.zero,
      A.zero,
      values,
    )
  end

  # 区間加算、区間最小
  def self.range_add_range_min(n : I)
    values = Array(X).new(n) { X::MAX }
    range_add_range_min(values)
  end

  # 区間加算、区間最小
  def self.range_add_range_min(n : I, init : X)
    values = Array(X).new(n) { init }
    range_add_range_min(values)
  end

  # 区間加算、区間最小
  def self.range_add_range_min(values : Array(X))
    new(
      Proc(X, X, X).new { |x, y| Math.min x, y },
      Proc(X, A, X).new { |x, a| x + a },
      Proc(A, A, A).new { |a, b| a + b },
      X::MAX,
      A.zero,
      values
    )
  end

  # 区間加算、区間最大
  def self.range_add_range_max(n : I)
    values = Array(X).new(n, X.zero)
    range_add_range_max(values)
  end

  # 区間加算、区間最大
  # 区間加算、区間最大
  # 常に０以上を返す
  def self.range_add_range_max(values : Array(X))
    new(
      Proc(X, X, X).new { |x, y| Math.max x, y },
      Proc(X, A, X).new { |x, a| x + a },
      Proc(A, A, A).new { |a, b| a + b },
      X.zero,
      A.zero,
      values
    )
  end

  # 区間更新、区間合計
  #
  # |x|   + |y|   = |x+y|
  # |1|     |1|     | 2 |
  #
  # |0 a| * |x|   = | 2a|
  # |0 1|   |2|     | 2 |
  #
  # |0 b| * |0 a| = |0 b|
  # |0 1|   |0 1|   |0 1|
  #
  # 更新は単位元を持たないため、nilを加えて単位元としている
  def self.range_update_range_sum(values : Array(X))
    new(
      Proc(X, X, X).new { |(x0, x1), (y0, y1)| {x0 + y0, x1 + y1} },
      Proc(X, A, X).new { |(x0, x1), a| a ? {x1 * a, x1} : {x0, x1} },
      Proc(A, A, A).new { |a, b| a && b ? b : b ? b : nil },
      X.new(0_i64, 1_i64),
      nil.as(A?),
      values
    )
  end

  def initialize(
    @fxx : Proc(X, X, X),
    @fxa : Proc(X, A, X),
    @faa : Proc(A, A, A),
    @x_unit,
    @a_unit,
    values : Array(X),
  )
    @n = Math.max 2, Math.pw2ceil(values.size)
    @x = Array(X).new(@n*2, x_unit)
    @a = Array(A).new(@n*2, a_unit)

    values.each_with_index do |v, i|
      x[i + n] = v
    end

    (n - 1).downto(1) do |i|
      x[i] = fxx.call x[lch(i)], x[rch(i)]
    end
  end

  def set(i : I, y : X)
    i += n
    propagate_above(i)
    x[i] = y
    a[i] = a_unit
    recalc_above(i)
  end

  def []=(i : I, y : X)
    set(i, y)
  end

  def fold(i : I, j : I) : X
    i += n
    j += n

    i0 = pa(i)
    j0 = pa(j) - 1

    propagate_above(i0)
    propagate_above(j0)

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

  def [](r : Range(I?, I?)) : X
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    fold(lo, hi)
  end

  def [](i : I) : X
    j = i.to_i
    fold(j, j + 1)
  end

  def update(i : I, j : I, b : A)
    i += n
    j += n

    i0 = pa(i)
    j0 = pa(j) - 1

    propagate_above(i0)
    propagate_above(j0)

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

    recalc_above(i0)
    recalc_above(j0)
  end

  def []=(r : Range(I?, I?), b : A)
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    update(lo, hi, b)
  end

  def recalc_above(i)
    while i > 1
      i >>= 1
      x[i] = fxx.call eval(lch(i)), eval(rch(i))
    end
  end

  def propagate_above(i)
    return if i.zero?
    Math.ilogb(i).downto(1) do |n|
      propagate(i >> n)
    end
  end

  def propagate(i)
    return if a[i] == a_unit
    a[lch(i)] = faa.call a[lch(i)], a[i]
    a[rch(i)] = faa.call a[rch(i)], a[i]
    x[i] = eval(i)
    a[i] = a_unit
  end

  @[AlwaysInline]
  def eval(i : I) : X?
    fxa.call x[i], a[i]
  end

  @[AlwaysInline]
  def lch(i)
    i << 1
  end

  @[AlwaysInline]
  def rch(i)
    i << 1 | 1
  end

  @[AlwaysInline]
  def pa(i)
    i // (i & -i)
  end

  def pp
    puts "\n# node"
    i = 1
    while i <= n
      sep = " " * ((n * 2) // i - 1)
      puts x[i...(i << 1)].join(sep)
      i <<= 1
    end

    puts "\n# lazy"
    i = 1
    while i <= n
      sep = " " * ((n * 2) // i - 1)
      puts a[i...(i << 1)].join(sep)
      i <<= 1
    end
  end
end
