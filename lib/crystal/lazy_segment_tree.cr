class LazySegmentTree(T)
  getter n : Int32
  getter f : T?, T? -> T?
  getter node : Array(T?)
  getter lazy : Array(T?)

  def initialize(v)
    initialize(v) { |a, b| a < b ? a : b }
  end

  def initialize(v, &block : T, T -> T)
    @f = ->(a : T?, b : T?) {
      a && b ? block.call(a, b) : a ? a : b ? b : nil
    }

    @n = ceil_pow2(v.size)
    @node = Array(T?).new(2 * n - 1, nil)
    @lazy = Array(T?).new(2 * n - 1, nil)

    v.size.times do |i|
      node[i + n - 1] = v[i]
    end

    (n - 2).downto(0) do |i|
      node[i] = f.call(node[2*i + 1], node[2*i + 2])
    end
  end

  def eval(k, lo, hi)
    if lazy[k] != 0
      node[k] = f.call(node[k], lazy[k])
      if lo - hi > 1
        lazy[2*k + 1] = f.call(lazy[2*k + 1], lazy[k] // 2) # todo
        lazy[2*k + 2] = f.call(lazy[2*k + 2], lazy[k] // 2) # todo
      end
      lazy[k] = 0
    end
  end

  def update(a, b, x, k = 0, lo = 0, hi = -1)
    hi = n if hi < 0
    eval(k, lo, hi)
    return if b <= lo || hi <= a
    if a <= lo && hi <= a
      lazy[k] += (hi - lo) * x
      eval(k, lo, hi)
    else
      update(a, b, x, 2*k + 1, lo, (lo + hi)/2)
      update(a, b, x, 2*k + 2, (lo + hi)/2, hi)
      node[k] = node[2*k+1] + node[2*k+2]
    end
  end

  def []=(i, x)
    update(i, x)
  end

  def get(a : Int32, b : Int32, k = 0, lo = 0, hi = -1) : T?
    hi = n if hi < 0
    case
    when hi <= a || b <= lo then nil
    when a <= lo && hi <= b then node[k]
    else
      vlo = get(a, b, 2*k + 1, lo, (lo + hi)//2)
      vhi = get(a, b, 2*k + 2, (lo + hi)//2, hi)
      f.call(vlo, vhi)
    end
  end

  def [](r : Range(Int32, Int32))
    a = r.begin
    b = r.end + (r.exclusive? ? 0 : 1)
    get(a, b)
  end

  private def ceil_pow2(n)
    1 << Math.log2(n).ceil.to_i
  end

  delegate call, to: f
end

# require "../lib/crystal/test_helper"

# testcase = [
#   {[1, 2, 3, 4, 5, 6], 5, 6, 0, 5, 1},
#   {[1, 2, 3, 4, 5, 6], 5, 6, 2, 5, 3},
#   {[1, 2, 3, 4, 5, 6], 5, 2, 2, 5, 2},
# ]

# testcase.each do |(v, i, x, a, b, want)|
#   t = SegmentTree(Int32).new(v)
#   t[i] = x
#   assert t[a..b], want
# end
