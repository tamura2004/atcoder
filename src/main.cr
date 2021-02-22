class SegmentTree(X)
  getter n : Int32
  getter x : Array(X?)
  getter xx : Proc(X?, X?, X?)

  def initialize(_x : Array(X), &_xx : Proc(X, X, X))
    @n = Math.pw2ceil(_x.size)

    @xx = Proc(X?, X?, X?).new do |x, y|
      x && y ? _xx.call(x, y) : x ? x : y ? y : nil
    end

    @x = Array(X?).new(n*2, nil)
    _x.each_with_index { |v, i| x[i + n] = v }

    (n - 1).downto(1) do |i|
      x[i] = xx.call x[i << 1], x[i << 1 | 1]
    end
  end

  def []=(i : Int32, y : X?)
    raise "Bad index i=#{i}" unless (0...n).includes?(i)

    i += n
    x[i] = y
    while i > 1
      i >>= 1
      x[i] = xx.call x[i << 1], x[i << 1 | 1]
    end
  end

  def [](i : Int32) : X?
    x[i + n]
  end

  def [](i : Int32, j : Int32) : X?
    return nil if i == j
    raise "Bad index i=#{i}" unless (0...n).includes?(i)
    raise "Bad index j=#{j}" unless (1..n).includes?(j)

    i += n; j += n
    left = right = nil
    while i < j
      if i.odd?
        left = xx.call left, x[i]
        i += 1
      end

      if j.odd?
        j -= 1
        right = xx.call x[j], right
      end
      i >>= 1; j >>= 1
    end

    xx.call(left, right)
  end

  def pp
    i = 1
    while i <= n
      sep = " " * ((n * 2) // i - 1)
      puts x[i...(i << 1)].join(sep)
      i <<= 1
    end
  end
end

n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i64 }
st = SegmentTree(Int64).new(a) do |i, j|
  i.gcd(j)
end

ans = n.times.max_of do |i|
  st.xx.call(st[0, i], st[i + 1, n]) || 1
end

pp ans
