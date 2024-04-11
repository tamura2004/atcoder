# 遅延評価セグメント木
# 内部でnilを単位源としてモノイド化
# 交換則を要しない
class LST(X, A)
  alias R = Range(Int::Primitive?, Int::Primitive?)

  getter n : Int32
  getter x : Array(X?)
  getter a : Array(A?)
  getter fxx : Proc(X?, X?, X?)
  getter fxa : Proc(X?, A?, X?)
  getter faa : Proc(A?, A?, A?)

  # 範囲更新、範囲加算
  def self.range_update_range_sum(values : Array(Int64))
    RangeUpdateRangeSum.new(values)
  end

  class RangeUpdateRangeSum
    record X, sum : Int64, num : Int64
    alias A = Int64
    getter lst : LST(X, A)
    delegate "[]=", to: lst

    def initialize(values)
      @lst = LST(X, A).new(
        values: values.map { |sum| X.new(sum, 1_i64) },
        fxx: -> (x : X, y : X) { X.new(x.sum + y.sum, x.num + y.num) },
        fxa: -> (x : X, a : A) { X.new(a * x.num, x.num) },
        faa: -> (a : A, b : A) { b },
      )
    end

    def [](r)
      lst[r].sum
    end

    def to_a
      lst.to_a.map(&.sum)
    end
  end

  def initialize(
    n : Int32 | Int64,
    fxx : Proc(X, X, X),
    fxa : Proc(X, A, X),
    faa : Proc(A, A, A)
  )
    initialize(Array.new(n, nil.as(X?)), fxx, fxa, faa)
  end

  def initialize(
    values : Array(X?),
    fxx : Proc(X, X, X),
    fxa : Proc(X, A, X),
    faa : Proc(A, A, A)
  )
    @n = Math.pw2ceil(values.size)
    @x = Array.new(n*2, nil.as(X?))
    @a = Array.new(n*2, nil.as(A?))

    @fxx = Proc(X?, X?, X?).new do |x, y|
      x && y ? fxx.call(x, y) : x ? x : y ? y : nil
    end

    @fxa = Proc(X?, A?, X?).new do |x, a|
      x && a ? fxa.call(x, a) : x ? x : nil
    end

    @faa = Proc(A?, A?, A?).new do |a, b|
      a && b ? faa.call(a, b) : a ? a : b ? b : nil
    end

    values.each_with_index do |v, i|
      x[i + n] = v
    end

    (1..n - 1).reverse_each do |i|
      x[i] = @fxx.call(x[i*2], x[i*2 + 1])
    end
  end

  # 区間作用
  def apply(lo, hi, v : A)
    lo += n
    hi += n

    pa_lo = lo // (lo & -lo)
    pa_hi = hi // (hi & -hi)

    propagate(pa_lo)
    propagate(pa_hi - 1)

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

    update(pa_lo)
    update(pa_hi - 1)
  end

  def []=(r : R, v : A)
    lo = r.begin || 0
    hi = r.end.try(&.succ.-(r.excludes_end?.to_unsafe)) || n
    apply(lo, hi, v)
  end

  # 1点更新
  def put(i, v : X)
    i += n
    propagate(i)
    x[i] = v
    a[i] = nil
    update(i)
  end

  def []=(i, v : X)
    put(i, v)
  end

  def propagate(i)
    h = Math.ilogb(i)
    return if h.zero?

    (1..h).reverse_each do |j|
      propagate_node(i >> j)
    end
  end

  def propagate_node(i)
    return if a[i].nil?

    if !is_leaf?(i)
      a[i*2] = faa.call a[i*2], a[i]
      a[i*2 + 1] = faa.call a[i*2 + 1], a[i]
    end

    x[i] = fxa.call x[i], a[i]
    a[i] = nil
  end

  def update(i)
    h = Math.ilogb(i)
    return if h.zero?

    (1..h).each do |j|
      update_node(i >> j)
    end
  end

  def update_node(i)
    x[i] = fxx.call fxa.call(x[i*2], a[i*2]), fxa.call(x[i*2 + 1], a[i*2 + 1])
  end

  def query(lo, hi) : X?
    lo += n
    hi += n

    pa_lo = lo // (lo & -lo)
    pa_hi = hi // (hi & -hi)

    propagate(pa_lo)
    propagate(pa_hi - 1)

    left = right = nil

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

  def [](r : R)
    lo, hi = range_to_tuple(r)
    query(lo, hi).not_nil!
  end

  def range_to_tuple(r : R)
    lo = (r.begin || 0).clamp(0..n - 1)
    hi = (r.end.try(&.succ.-(r.excludes_end?.to_unsafe)) || n).clamp(0..n)
    { lo, hi }
  end

  def sum
    self[0..]
  end

  def is_leaf?(i)
    n <= i
  end

  #
  def ceil(i)
    i // (i & -i)
  end

  def to_a
    (0...n).map { |i| self[i..i] }
  end

  def to_s(io)
    Math.ilogb(n).succ.times do |h|
      (2**h...2**(h + 1)).each do |i|
        io << "#{x[i]}/#{a[i]} "
      end
      io << "\n"
    end
  end
end
