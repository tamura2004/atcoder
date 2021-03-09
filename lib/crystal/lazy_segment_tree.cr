# 遅延評価セグメント木
#
# ```
# # range add range sum
# alias Pair = Tuple(Int64, Int64)
# st = LazySegmentTree(Pair, Int64).new(
#   Proc(Pair, Pair, Pair).new { |(x, n), (y, m)| Pair.new x + y, n + m },
#   Proc(Pair, Int64, Pair).new { |(x, n), a| Pair.new x + n * a, n },
#   Proc(Int64, Int64, Int64).new { |a, b| a + b },
#   n: 4,
#   init: Pair.new(0_i64, 1_i64)
# ) # => [0, 0, 0, 0]
# st[..2] = 2_i64 # => [2, 2, 2, 0]
# st[2..] = 3_i64 # => [2, 2, 5, 3]
# st[1..2] = 4_i64 # => [2, 6, 9, 3]
# st[0..].should eq Pair.new(20_i64, 4_i64)
# # ```
class LazySegmentTree(X, A)
  getter n : Int32
  getter x : Array(X?)
  getter a : Array(A?)
  getter fxx : Proc(X?, X?, X?)
  getter fxa : Proc(X?, A?, X?)
  getter faa : Proc(A?, A?, A?)

  def self.range_add_range_min(_x)
    new(
      Proc(X,X,X).new { |x,y| Math.min x, y },
      Proc(X,A,X).new { |x,a| x + a },
      Proc(A,A,A).new { |a,b| a + b },
      _x
    )
  end

  def initialize(
    fxx : Proc(X,X,X),
    fxa : Proc(X,A,X),
    faa : Proc(A,A,A),
    n : Int32,
    init : X? = nil
    )
    x = Array(X?).new(n, init)
    initialize(fxx, fxa, faa, x)
  end
  
  def initialize(
    fxx : Proc(X,X,X),
    fxa : Proc(X,A,X),
    faa : Proc(A,A,A),
    _x : Array(X?)
  )
    @fxx = Proc(X?, X?, X?).new do |x, y|
      x && y ? fxx.call(x, y) : x ? x : y ? y : nil
    end

    @fxa = Proc(X?, A?, X?).new do |x, a|
      x && a ? fxa.call(x, a) : x ? x : nil
    end

    @faa = Proc(A?, A?, A?).new do |a, b|
      a && b ? faa.call(a, b) : a ? a : b ? b : nil
    end

    @n = Math.max 2, Math.pw2ceil(_x.size)
    @x = Array(X?).new(@n*2, nil)
    @a = Array(A?).new(@n*2, nil)

    _x.each_with_index do |v, i|
      x[i + n] = v
    end

    (n - 1).downto(1) do |i|
      x[i] = @fxx.call x[lch(i)], x[rch(i)]
    end
  end

  def set(i : Int32, y : X?)
    i += n
    propagate_above(i)
    x[i] = y
    a[i] = nil
    recalc_above(i)
  end

  def [](i : Int32, y : X?)
    set(i, y)
  end

  def fold(i : Int32, j : Int32) : X?
    i += n
    j += n

    i0 = pa(i)
    j0 = pa(j) - 1

    propagate_above(i0)
    propagate_above(j0)

    left = nil.as(X?)
    right = nil.as(X?)
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

  def [](r : Range(Int32?, Int32?)) : X?
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    fold(lo, hi)
  end

  def [](r : Range(Int32?, Int32?), default : X) : X
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    fold(lo, hi) || default
  end

  def update(i : Int32, j : Int32, b : A)
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

  def []=(r : Range(Int32?, Int32?), b : A)
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
    return if a[i].nil?
    a[lch(i)] = faa.call a[lch(i)], a[i]
    a[rch(i)] = faa.call a[rch(i)], a[i]
    x[i] = eval(i)
    a[i] = nil
  end

  @[AlwaysInline]
  def eval(i : Int32) : X?
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
