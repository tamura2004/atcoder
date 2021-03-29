# 答えを決め打つ二分探索
#
# ```
# BSearch(Int32).new do |i|
#   200 < i * i
# end.min_of(0, 200) # => 15
# ```
class BSearch(T)
  getter c : Proc(T, Bool)

  def initialize(&@c : Proc(T, Bool))
  end

  # 条件がloで常に成立するとき
  # 最大のloを求める
  def max_of(lo , hi)
    raise "bad lo = #{lo}" unless c.call(lo)
    raise "bad hi = #{hi}" if c.call(hi)

    while hi - lo > 1
      mid = (lo + hi)//2
      if c.call(mid)
        lo = mid
      else
        hi = mid
      end
    end
    return lo
  end

  # 条件がloで常に成立するとき
  # 試行回数を固定して最大のloを求める
  def max_of(lo, hi, n)
    raise "bad lo = #{lo}" unless c.call(lo)
    raise "bad hi = #{hi}" if c.call(hi)

    n.times do
      mid = (lo + hi)/2
      if c.call(mid)
        lo = mid
      else
        hi = mid
      end
    end
    return lo
  end

  # 条件がhiで常に成立するとき
  # 最小のhiを求める
  def min_of(lo, hi)
    raise "bad lo = #{lo}" if c.call(lo)
    raise "bad hi = #{hi}" unless c.call(hi)

    while hi - lo > 1
      mid = (lo + hi)//2
      if c.call(mid)
        hi = mid
      else
        lo = mid
      end
    end
    return hi
  end

  # 条件がhiで常に成立するとき
  # 試行回数を固定して最小のhiを求める
  def min_of(lo, hi, n)
    raise "bad lo = #{lo}" if c.call(lo)
    raise "bad hi = #{hi}" unless c.call(hi)

    n.times do
      mid = (lo + hi)/2
      if c.call(mid)
        hi = mid
      else
        lo = mid
      end
    end
    return hi
  end
end
