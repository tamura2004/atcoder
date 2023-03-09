class SegmentTree2D(T)
  getter w : Int32
  getter h : Int32
  getter unit : T
  getter a : Array(T)
  getter f : Proc(T,T,T)

  private def id(y, x)
    y * 2 * w + x
  end

  def initialize(@h, @w, @unit, &@f)
    @h = Math.pw2ceil(h)
    @w = Math.pw2ceil(w)
    @a = Array.new(h*4*w, unit)
  end

  # build前のみ
  def set(y, x, v)
    a[id(y,x)] = v
  end

  def build
    # w in [W, 2W)
    (w...w*2).each do |x|
      (1...h).reverse_each do |y|
        a[id(y,x)] = f.call a[id(y*2,x)], a[id(y*2+1,x)]
      end
    end
    
    # h in [0, 2H)
    (0...h*2).each do |y|
      (1...w).reverse_each do |x|
        a[id(y,x)] = f.call a[id(y,x*2)], a[id(y,x*2+1)]
      end
    end
  end

  def get(y, x)
    a[y+h,x+w]
  end

  def [](y,x)
    get(y,x)
  end

  def update(y,x,v)
    y += h
    x += w

    a[id(y,x)] = v

    i = h >> 1
    while i > 0
      a[id(i,w)] = f.call a[id(i*2,w)], a[id(i*2+1,w)]
      i >>= 1
    end

    while y > 0
      j = w >> 1
      while j > 0
        seg[id(y, j)] = f.call a[id(y, j * 2)], a[id(y,j*2+1)]
        j >>= 1
      end
      y >>= 1
    end
  end

  def _inner_query(y, x1,x2)
    left = right = unit
    while x1 < x2
      if x1.odd?
        left = f.call left, a[id(y,x1)]
        x1 += 1
      end
      if x2.odd?
        x2 -= 1
        right = f.call a[id(y,x2)], right
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
        left = f.call left, _inner_query(y1,x1,x2)
        y1 -= 1
      end
      if y2.odd?
        y2 -= 1
        right = f.call _inner_query(y2,x1,x2), right
      end
      y1 >>= 1
      y2 >>= 1
    end
    f.call left, right
  end
end
