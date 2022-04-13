def read(s)
  case s
  when /\./
    a,b = s.split(/\./)
    b = (b + "0000")[0,4]
    a.to_i64 * 10000 + b.to_i64
  else
    s.to_i64 * 10000
  end
end

def sqrt(x)
  lo = 0_i64
  hi = 2e9.to_i64
  (lo..hi).bsearch do |mid|
    x <= mid ** 2
  end.not_nil!
end

INF = 1e10.to_i64

x,y,r = gets.to_s.split.map{|s|read(s)}

bottom = divceil(y - r, 10000) * 10000
top = (y + r) // 10000 * 10000

ans = 0_i64
bottom.step(by: 10000, to: top) do |ny|
  nx = sqrt(r ** 2 - (ny - y) ** 2)
  left = divceil(x - nx, 10000)
  right = (x - nx) // 10000
  if left <= right
    ans += (left..right).size
  end
end

pp ans
