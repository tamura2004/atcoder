# 答えを決め打つ二分探索
# 答えがXの時K回充足するか

require "crystal/multiset"

struct Range(B, E)
  def tsearch_index(&block : B | E -> Int64)
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

  def tsearch(&block : B | E -> Int64)
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

def cost(ms, lo, hi)
  acc_left = ms.acc_lower(lo, eq: false) || 0_i64
  cnt_left = ms.count_lower(lo, eq: false) || 0

  acc_right = ms.acc_upper(hi, eq: false) || 0_i64
  cnt_right = ms.count_upper(hi, eq: false) || 0
  
  lo * cnt_left - acc_left + acc_right - hi * cnt_right
end

n, k = gets.to_s.split.map(&.to_i64)
xy = Array.new(n) do
  x, y = gets.to_s.split.map(&.to_i64)
  {x, y}
end

x = xy.map(&.[0])
y = xy.map(&.[1])

msx = x.to_multiset_sum
msy = y.to_multiset_sum

lo = 0_i64
hi = 1e10.to_i64
ans = (lo..hi).bsearch do |n|
  x_cost = (lo..hi).tsearch do |left|
    cost(msx, left, left + n)
  end
  y_cost = (lo..hi).tsearch do |left|
    cost(msy, left, left + n)
  end
  x_cost + y_cost <= k
end

pp ans
