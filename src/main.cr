def f1(a, b, x)
  (a + b + x)//2
end

def f2(a, b, x)
  Math.max b, a + x - (b - a)
end

def f(a, b, x)
  return -1 if b - a > x
  return b + x + 1 if b <= a
  Math.max f1(a, b, x) + 1, f2(a, b, x) + 1
end

n, m = gets.to_s.split.map(&.to_i64)
a = Array.new(m) { gets.to_s.to_i64 - 1 }

ok = ->(x : Int64) {
  pos = 0_i64
  m.times do |i|
    pos = f(pos, a[i], x)
    break if pos < 0
  end
  pos >= n
}

lo = 0_i64
hi = Int64::MAX
ans = (lo..hi).bsearch(&ok)
pp ans
