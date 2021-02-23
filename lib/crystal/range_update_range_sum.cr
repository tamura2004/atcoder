# 遅延評価セグメント木
#
# ```
# alias X = Tuple(ModInt, ModInt)
# alias A = Tuple(ModInt, ModInt)
# alias XX = X?, X? -> X?
# alias AA = A?, A? -> A?
# alias XA = X?, A? -> X?
# xx = Proc(X,X,X).new do |(x0, x1), (y0, y1)|
#   {x0 + y0, x1 + y1}
# end
# xa = Proc(X,A,X).new do |(x0, x1), (a0, a1)|
#   {x0 * a0 + x1 * a1, x1}
# end
# aa = Proc(A,A,A).new do |(a0, a1), (b0, b1)|
#   {a0 * b0, a1 * b0 + b1}
# end
# st = LazySegmentTree(X,A,XX,XA,AA).new(a, xx, xa, aa)
#
# ```
class LazySegmentTree(X,A,XX,XA,AA)
  getter n : Int32
  getter x : Array(X?)
  getter a : Array(A?)
  getter xx : XX
  getter xa : XA
  getter aa : AA

  def initialize(n : Int32, xx, xa, aa)
    x = Array(X?).new(n, nil)
    initialize(x, xx, xa, aa)
  end

  def initialize(_x : Array(X?), xx, xa, aa)
    @xx = XX.new do |x,y|
      x && y ? xx.call(x, y) : x ? x : y ? y : nil
    end

    @xa = XA.new do |x,a|
      x && a ? xa.call(x, a) : x ? x : nil
    end

    @aa = AA.new do |a,b|
      a && b ? aa.call(a, b) : a ? a : b ? b : nil
    end

    @n = Math.max 2, Math.pw2ceil(_x.size)
    @x = Array(X?).new(@n*2, nil)
    @a = Array(A?).new(@n*2, nil)

    _x.each_with_index do |v, i|
      x[i + n] = v
    end

    (n - 1).downto(1) do |i|
      x[i] = @xx.call x[lch(i)], x[rch(i)]
    end
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

  def set(i : Int32, y : X?)
    i += n
    propagate_above(i)
    x[i] = y
    a[i] = nil
    recalc_above(i)
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
        left = xx.call left, eval(i)
        i += 1
      end
      if j.odd?
        j -= 1
        right = xx.call eval(j), right
      end
      i >>= 1
      j >>= 1
    end
    xx.call left, right
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
        a[i] = aa.call a[i], b
        i += 1
      end
      if j.odd?
        j -= 1
        a[j] = aa.call a[j], b
      end
      i >>= 1
      j >>= 1
    end

    recalc_above(i0)
    recalc_above(j0)
  end

  def recalc_above(i)
    while i > 1
      i >>= 1
      x[i] = xx.call eval(lch(i)), eval(rch(i))
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
    a[lch(i)] = aa.call a[lch(i)], a[i]
    a[rch(i)] = aa.call a[rch(i)], a[i]
    x[i] = eval(i)
    a[i] = nil
  end

  def eval(i : Int32) : X?
    xa.call x[i], a[i]
  end

  def lch(i)
    i << 1
  end

  def rch(i)
    i << 1 | 1
  end

  def pa(i)
    i // (i & -i)
  end
end

alias X = Tuple(UInt128, UInt128)
alias A = UInt128
alias XX = X?, X? -> X?
alias AA = A?, A? -> A?
alias XA = X?, A? -> X?

# |x| + |y| = |x+y|
# |1|   |1|   | 2 |
xx = Proc(X,X,X).new do |(x0, x1), (y0, y1)|
  {x0 + y0, x1 + y1}
end

# |0 z| * |x| = |2z|
# |0 1|   |2|   | 2|
xa = Proc(X,A,X).new do |(x0, x1), a|
  {x1 * a, x1}
end

# |0 b| * |0 a| = |0 b|
# |0 1|   |0 1|   |0 1|
aa = Proc(A,A,A).new do |a, b|
  b
end

n,m = gets.to_s.split.map { |v| v.to_i }
st = LazySegmentTree(X,A,XX,XA,AA).new(n, xx, xa, aa)
unit = { 0.to_u128, 1.to_u128 }
n.times{|i|st.set(i, unit)}

ans = 0.to_u128
m.times do
  t,l,r = gets.to_s.split.map { |v| v.to_i - 1 }
  t = (t + 1).to_u128
  ans += t * (l..r).size
  ans -= st.fold(l, r + 1).try(&.first) || 0
  st.update(l, r + 1, t)
end

pp ans
