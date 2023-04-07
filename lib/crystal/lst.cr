class LST(X, A)
  getter n : Int32
  getter x : Array(X?)
  getter a : Array(A?)
  getter fxx : Proc(X?, X?, X?)
  getter fxa : Proc(X?, A?, X?)
  getter faa : Proc(A?, A?, A?)

  def initialize(
    values : Array(X),
    gxx : Proc(X, X, X),
    gxa : Proc(X, A, X),
    gaa : Proc(A, A, A)
  )
    @n = Math.pw2ceil(values.size)
    @x = Array.new(n*2, nil.as(X?))
    @a = Array.new(n*2, nil.as(A?))

    @fxx = Proc(X?, X?, X?).new do |x, y|
      x && y ? gxx.call(x, y) : x ? x : y ? y : nil
    end

    @fxa = Proc(X?, A?, X?).new do |x, a|
      x && a ? gxa.call(x, a) : x ? x : nil
    end

    @faa = Proc(A?, A?, A?).new do |a, b|
      a && b ? gaa.call(a, b) : a ? a : b ? b : nil
    end

    values.each_with_index do |v, i|
      x[i + n] = v
    end

    (1..n - 1).reverse_each do |i|
      x[i] = fxx.call(x[i*2], x[i*2 + 1])
    end
  end

  # 区間作用
  def apply(lo, hi, v : A)
    lo += n
    hi += n

    pa_lo = lo // (lo & -lo)
    pa_hi = (hi - 1) // ((hi - 1) & -(hi - 1))

    propagate(pa_lo)
    propagate(pa_hi)

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
    update(pa_hi)
  end

  def propagate(node_id)
    node_id >>= 1
    i = 0
    (0...Math.ilogb(node_id).succ).reverse_each do |h|
      i = (i << 1) + node_id.bit(h)
      propagate_node(i)
    end
  end

  def propagate_node(i)
    if lazy = a[i]
      if !is_leaf?(i)
        a[i*2] = faa.call a[i*2], lazy
        a[i*2 + 1] = faa.call a[i*2 + 1], lazy
      end
      x[i] = fxa.call x[i], lazy
      a[i] = nil
    end
  end

  def update(i)
    i >>= 1
    while i > 0
      update_node(i)
      i >>= 1
    end
  end

  def update_node(i)
    x[i] = fxx.call fxa.call(x[i*2], a[i*2]), fxa.call(x[i*2 + 1], a[i*2 + 1])
  end

  def query(lo, hi)
    lo += n
    hi += n

    pa_lo = lo // (lo & -lo)
    pa_hi = (hi - 1) // ((hi - 1) & -(hi - 1))

    propagate(pa_lo)
    propagate(pa_hi)

    update(pa_lo)
    update(pa_hi)

    left = right = nil

    while lo < hi
      if lo.odd?
        x[lo] = fxa.call x[lo], a[lo]
        a[lo] = nil
        left = fxx.call left, x[lo]
        lo -= 1
      end

      if hi.odd?
        hi -= 1
        x[hi] = fxa.call x[hi], a[hi]
        a[hi] = nil
        right = fxx.call x[hi], right
      end

      lo >>= 1
      hi >>= 1
    end

    fxx.call left, right
  end

  def is_leaf?(i)
    n <= i
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
