# deprecated!
# lib/crystal/lst.crを使用すること

require "crystal/i_segment_tree"

# 遅延評価セグメント木
class LazySegmentTree(X, A)
  alias I = Int::Signed
  # include ISegmentTree(X)

  getter fxx : Proc(X, X, X)
  getter fxa : Proc(X, A, X)
  getter faa : Proc(A, A, A)
  getter x_unit : X
  getter a_unit : A
  getter n : I
  getter x : Array(X)
  getter a : Array(A)

  # 演算と単位元で初期化
  #
  def initialize(
    values : Array(X),
    @fxx : Proc(X, X, X) = Proc(X, X, X).new { |x, y| x + y },
    @fxa : Proc(X, A, X) = Proc(X, A, X).new { |x, a| x * a },
    @faa : Proc(A, A, A) = Proc(A, A, A).new { |a, b| a * b },
    @x_unit = X.zero,
    @a_unit = A.zero
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

  # 要素数で初期化
  def initialize(
    n : Int32,
    @fxx : Proc(X, X, X) = Proc(X, X, X).new { |x, y| x + y },
    @fxa : Proc(X, A, X) = Proc(X, A, X).new { |x, a| x * a },
    @faa : Proc(A, A, A) = Proc(A, A, A).new { |a, b| a * b },
    @x_unit = X.zero,
    @a_unit = A.zero
  )
    values = [x_unit] * n
    initialize(values, fxx, fxa, faa, x_unit, a_unit)
  end

  # 区間更新、区間最小
  def self.range_update_range_min(n : I)
    values = Array(X).new(n) { X::MAX }
    range_update_range_min(values)
  end

  # 区間更新、区間最小
  def self.range_update_range_min(n : I, init : X)
    values = Array(X).new(n) { init }
    range_update_range_min(values)
  end

  # 区間更新、区間最小
  def self.range_update_range_min(values : Array(X))
    new(
      values: values,
      fxx: ->Math.min(X, X),
      fxa: ->Math.min(X, A),
      faa: ->Math.min(A, A),
      x_unit: X::MAX,
      a_unit: A::MAX,
    )
  end

  # 区間更新、区間最小
  def self.range_update_range_max(n : I)
    values = Array(X).new(n) { X::MIN }
    range_update_range_max(values)
  end

  # 区間更新、区間最大
  def self.range_update_range_max(n : I, init : X)
    values = Array(X).new(n) { init }
    range_update_range_max(values)
  end

  # 区間更新、区間最大
  def self.range_update_range_max(values : Array(X))
    new(
      values: values,
      fxx: ->Math.max(X, X),
      fxa: ->Math.max(X, A),
      faa: ->Math.max(A, A),
      x_unit: X::MIN,
      a_unit: A::MIN,
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
      values,
      Proc(X, X, X).new { |x, y| Math.min x, y },
      Proc(X, A, X).new { |x, a| x + a },
      Proc(A, A, A).new { |a, b| a + b },
      X::MAX,
      A.zero,
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
      values,
      Proc(X, X, X).new { |x, y| Math.max x, y },
      Proc(X, A, X).new { |x, a| x + a },
      Proc(A, A, A).new { |a, b| a + b },
      X.zero,
      A.zero,
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
  # def self.range_update_range_sum(n : Int)
  #   new(
  #     values: Array.new(n) { nil.as(X) },
  #     fxx: -> (x : X, y : X) {
  #       x && y ? X.new(x[0] + y[0], x[1] + y[1]) : x ? x : y ? y : nil
  #     },
  #     fxa: -> (x : X, a : A) {
  #       x && a ? X.new(a * x[1], x[1]) : x ? x : nil
  #     },
  #     faa: -> (a : A, b : A) {
  #       b ? b : a
  #     },
  #     x_unit: nil.as(X),
  #     a_unit: nil.as(A)
  #   )
  # end

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

  def [](r : Range(Int::Primitive?, Int::Primitive?)) : X
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

  def fx
    fxx
  end

  def unit
    x_unit
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
