# 遅延評価セグメント木
#
# ```
# n = 10
# xy = -> (x : Int64, y : Int64) { Math.min x, y }
# xa = -> (x : Int64, a : Int64) { x + a }
# ab = -> (a : Int64, b : Int64) { a + b }
# st = LazySegmentTree(Int64,Int64).new(n,xy,xa,ab)
# st.set(10, 20_i64)
# st.fold(0,20) # => 20
# ```
class LazySegmentTree(X, A)
  getter n : Int32
  getter x : Array(X?)
  getter a : Array(A?)
  getter xy : X?, X? -> X?
  getter xa : X?, A? -> X?
  getter ab : A?, A? -> A?

  def initialize(n : Int32, xy : X, X -> X, xa : X, A -> X, ab : A, A -> A)
    x = Array(X?).new(n, nil)
    initialize(x, xy, xa, ab)
  end
  
  def initialize(_x : Array(X?), xy : X, X -> X, xa : X, A -> X, ab : A, A -> A)
    @xy = -> (x : X?, y : X?) do
      x && y ? xy.call(x,y) : x ? x : y ? y : nil
    end

    @xa = -> (x : X?, a : A?) do
      x && a ? xa.call(x,a) : x ? x : nil
    end

    @ab = -> (a : A?, b : A?) do
      a && b ? ab.call(a,b) : a ? a : b ? b : nil
    end

    @n = Math.max 2, Math.pw2ceil(_x.size)
    @x = Array(X?).new(@n*2, nil)
    @a = Array(A?).new(@n*2, nil)

    _x.each_with_index do |v,i|
      x[i+n] = v
    end

    (n-1).downto(1) do |i|
      x[i] = @xy.call x[lch(i)], x[rch(i)]
    end
  end

  def pp
    puts "\n# node"
    i = 1
    while i <= n
      sep = " " * (16 // i - 1)
      puts x[i...(i << 1)].join(sep)
      i <<= 1
    end

    puts "\n# lazy"
    i = 1
    while i <= n
      sep = " " * (16 // i - 1)
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
    j0 = pa(j-1)

    propagate_above(i0)
    propagate_above(j0)

    left = nil.as(X?)
    right = nil.as(X?)
    while i < j
      if i.odd?
        left = xy.call left, eval(i)
        i += 1
      end
      if j.odd?
        j -= 1
        right = xy.call eval(j), right
      end
      i >>= 1
      j >>= 1
    end
    xy.call left, right
  end

  def update(i : Int32, j : Int32, b : A)
    i += n
    j += n

    i0 = pa(i)
    j0 = pa(j-1)

    propagate_above(i0)
    propagate_above(j0)

    while i < j
      if i.odd?
        a[i] = ab.call a[i], b
        i += 1
      end
      if j.odd?
        j -= 1
        a[j] = ab.call a[j], b
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
      x[i] = xy.call eval(lch(i)), eval(rch(i))
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
    a[lch(i)] = ab.call a[lch(i)], a[i]
    a[rch(i)] = ab.call a[rch(i)], a[i]
    x[i] = eval(i)
    a[i] = nil
  end

  def eval(i : Int32)
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

alias Pair = Tuple(Int64,Int64)
MOD = 998244353_i64

ab = -> (a : Pair, b : Pair) do
  { a[0] * b[0], a[1] * b[0] + b[1] }
end
xy = -> (x : Pair, y : Pair) do
  { (x[0] + y[0]) % MOD, (x[1] + y[1]) % MOD }
end
xa = -> (x : Pair, a : Pair) do
  { ((x[0] * a[0]) % MOD + (x[1] * a[1]) % MOD) % MOD, 1_i64 }
end

n,q = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| ({ v.to_i64, 1_i64}) }
st = LazySegmentTree(Pair,Pair).new(a,xy,xa,ab)

q.times do
  line = gets.to_s.split.map { |v| v.to_i }
  case line[0]
  when 0
    _,l,r,b,c = line
    st.update(l,r,{b.to_i64, c.to_i64})
  when 1
    _,l,r = line
    puts st.fold(l,r).try(&.[] 0)
  end
end
