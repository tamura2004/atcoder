require "crystal/range_to_tuple"

class SegmentTree2D(T)
  getter w : Int64
  getter h : Int64
  getter unit : T
  getter a : Hash(Int64, T)
  getter f : Proc(T, T, T)

  def id(y, x)
    y.to_i64 * 2 * w + x
  end

  def initialize(_h, _w, @unit, &@f : T, T -> T)
    @h = Math.pw2ceil(_h).to_i64
    @w = Math.pw2ceil(_w).to_i64
    @a = Hash(Int64, T).new(unit)
  end

  # build前のみ
  def set(y, x, v)
    a[id(y + h, x + w)] = v
  end

  def build
    # w in [W, 2W)
    (w...w*2).each do |x|
      (1...h).reverse_each do |y|
        val = f.call a[id(y*2, x)], a[id(y*2 + 1, x)]
        a[id(y, x)] = val if val != unit
      end
    end

    # h in [0, 2H)
    (0...h*2).each do |y|
      (1...w).reverse_each do |x|
        val = f.call a[id(y, x*2)], a[id(y, x*2 + 1)]
        a[id(y, x)] = val if val != unit
      end
    end
  end

  def update(y, x, v)
    y += h
    x += w

    a[id(y, x)] = v

    i = y >> 1
    while i > 0
      a[id(i, x)] = f.call a[id(i*2, x)], a[id(i*2 + 1, x)]
      i >>= 1
    end

    while y > 0
      j = x >> 1
      while j > 0
        a[id(y, j)] = f.call a[id(y, j * 2)], a[id(y, j*2 + 1)]
        j >>= 1
      end
      y >>= 1
    end
  end

  def []=(y, x, v)
    update(y, x, v)
  end

  def _inner_query(y, x1, x2)
    left = right = unit
    while x1 < x2
      if x1.odd?
        left = f.call left, a[id(y, x1)]
        x1 += 1
      end
      if x2.odd?
        x2 -= 1
        right = f.call a[id(y, x2)], right
      end
      x1 >>= 1
      x2 >>= 1
    end
    f.call left, right
  end

  # [ (h1,w1), (h2,w2) ) 半開区間
  def query(y1, y2, x1, x2)
    if y1 >= y2 || x1 >= x2
      return unit
    end
    left = right = unit
    y1 += h
    y2 += h
    x1 += w
    x2 += w
    while y1 < y2
      if y1.odd?
        left = f.call left, _inner_query(y1, x1, x2)
        y1 += 1
      end
      if y2.odd?
        y2 -= 1
        right = f.call _inner_query(y2, x1, x2), right
      end
      y1 >>= 1
      y2 >>= 1
    end
    f.call left, right
  end

  def [](y1, y2, x1, x2)
    query(y1, y2, x1, x2)
  end

  def [](r1, r2)
    y1, y2 = RangeToTuple(Int32).from(r1, min: 0, max: h)
    x1, x2 = RangeToTuple(Int32).from(r2, min: 0, max: w)
    query(y1, y2, x1, x2)
  end
end
