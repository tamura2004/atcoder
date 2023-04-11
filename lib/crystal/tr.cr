# セグメント木
class TR(T)
  getter n : Int32
  getter a : Array(T?)
  getter fxx : Proc(T?, T?, T?)

  def initialize(values : Array(T), fxx : Proc(T, T, T))
    @fxx = ->(x : T?, y : T?) do
      x && y ? fxx.call(x, y) : x ? x : y ? y : nil
    end

    @n = Math.pw2ceil(values.size)
    @a = Array.new(n*2) { nil.as(T?) }
    values.each_with_index do |v, i|
      a[i + n] = v
    end
    (1...n).reverse_each do |i|
      a[i] = @fxx.call(a[i*2], a[i*2 + 1])
    end
  end

  def put(i, v : T)
    i += n
    a[i] = v
    while i > 1
      i >>= 1
      a[i] = fxx.call(a[i*2], a[i*2 + 1])
    end
  end

  def []=(i, v)
    put(i, v)
  end

  def get(i)
    a[i+n]
  end

  def [](i : Int)
    get(i).not_nil!
  end

  def query(lo, hi)
    lo += n
    hi += n

    left = right = nil.as(T?)

    while lo < hi
      if lo.odd?
        left = fxx.call left, a[lo]
        lo += 1
      end

      if hi.odd?
        hi -= 1
        right = fxx.call a[hi], right
      end

      lo >>= 1
      hi >>= 1
    end

    fxx.call left, right
  end

  def [](lo, hi)
    query(lo, hi).not_nil!
  end

  def [](r : Range(Int::Primitive?, Int::Primitive?))
    lo = r.begin || 0
    hi = r.end.try(&.-(1).+(r.excludes_end?.to_unsafe)) || n
    self[lo, hi]
  end

  def sum
    self[0..]
  end

  def to_s(io)
    (0..Math.ilogb(n)).each do |h|
      io << a[(1<<h)...(1<<(h+1))].join(" ")
      io << "\n"
    end
  end
end
