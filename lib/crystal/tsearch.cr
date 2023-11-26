# 三分探索
# 下に凸を仮定
struct Range(B, E)
  # インデックスを返す
  def tsearch_index(&block : B | E -> Int64 | Int32)
    lo = left = self.begin
    hi = right = self.end

    while hi - lo > 3
      left = (lo * 2 + hi) // 3
      right = (lo + hi * 2) // 3
      if block.call(left) < block.call(right)
        hi = right
      else
        lo = left
      end
    end

    case
    when block.call(lo) < block.call(left)
      lo
    when block.call(right) > block.call(hi)
      hi
    when block.call(left) < block.call(right)
      left
    else
      right
    end
  end

  # 値を返す
  def tsearch(&block : B | E -> Int64 | Int32)
    lo = left = self.begin
    hi = right = self.end

    while hi - lo > 3
      left = (lo * 2 + hi) // 3
      right = (lo + hi * 2) // 3
      if block.call(left) < block.call(right)
        hi = right
      else
        lo = left
      end
    end

    [lo,left,right,hi].map(&block).min
  end
end