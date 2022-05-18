class ST
  getter a : Array(Int64)
  getter n : Int32

  def initialize(values)
    _n = values.size
    @n = Math.pw2ceil(_n)
    @a = Array.new(n*2, 0_i64)
    a[n, _n] = values.map(&.to_i64)
    (1...n).reverse_each { |i| a[i] = a[i*2] + a[i*2 + 1] }
  end

  def query(lo, hi)
    lo += n
    hi += n
    ans = 0_i64

    while lo < hi
      ans += a[lo] if lo.odd?
      ans += a[hi - 1] if hi.odd?
      lo = (lo + 1) // 2
      hi //= 2
    end

    ans
  end

  def []=(r : Range(Int::Primitive?, Int::Primitive?))
    lo = r.begin || 0
    hi = (r.end || n) + (r.excludes_end? ? 0 : 1)
    query(lo, hi)
  end

  def update(i, v)
    i += n
    a[i] = v.to_i64

    while 1 < i
      i //= 2
      a[i] = a[i*2] + a[i*2 + 1]
    end
    v
  end

  def []=(i, v)
    update(i, v)
  end

  def fetch(i)
    a[i + n]
  end

  def [](i)
    fetch(i)
  end
end

st = ST.new([3, 4, 5])
pp st
pp st.query(0, 4)
pp st.query(1, 3)
pp st.query(1, 2)

pp st.fetch(1)
st[1] += 5
pp st.fetch(1)
