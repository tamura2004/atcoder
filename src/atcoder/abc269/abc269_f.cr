require "crystal/modint9"

n, m = gets.to_s.split.map(&.to_i64)
HALF = 1.to_m // 2

# 初項init,公差r,長さnの数列の和
def f(init, r, n)
  init = init.to_m
  r = r.to_m
  n = n.to_m
  (init + init + r * (n - 1)) * n * HALF
end

query = -> (a : Int64, b : Int64, c : Int64, d : Int64) do
  init = (a - 1) * m + c
  r = 2
  len = (d - c) // 2 + 1
  
  head_row = f(init, r, len)
  r = len * m * 2
  len = (b - a) // 2 + 1

  f(head_row, r, len)
end

q = gets.to_s.to_i
q.times do
  a,b,c,d = gets.to_s.split.map(&.to_i64)
  
  case a + c
  when .even?
    ans = query.call(a,b,c,d)
    if a + 1 <= n && c + 1 <= m
      ans += query.call(a+1,b,c+1,d)
    end
    pp ans
  when .odd?
    ans = 0.to_m
    if a + 1 <= n
      ans += query.call(a+1,b,c,d)
    end
    if c + 1 <= m
      ans += query.call(a,b,c+1,d)
    end
    pp ans
  end
end
