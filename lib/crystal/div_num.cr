# 長さnの分割数
def divnum(n : Int32) : Deque(Array(Int32))
  ans = Deque(Array(Int32)).new
  q = Deque(Array(Int32)).new
  1.upto(n) do |i|
    q << [i]
  end

  while q.size > 0
    v = q.pop
    s = v.sum
    if s == n
      ans << v
    else
      m = Math.min(n - s, v[-1])
      1.upto(m) do |j|
        q << v + [j]
      end
    end
  end
  return ans
end
