require "crystal/modint9"

# 事前計算によりO(1)で二項係数を求める
#
class FactTable
  getter m : Int32
  getter f : Array(ModInt)
  getter finv : Array(ModInt)

  def initialize(m)
    @m = m.to_i
    @f = [ModInt.new(1)]
    (1..m).each { |i| f << f.last * i }

    @finv = [f[m].inv]
    (1..m).each { |i| finv << finv.last * (m + 1 - i)}
    finv.reverse!
  end

  def p(n, k)
    return ModInt.zero if n < k
    return ModInt.zero if k < 0

    f[n] * finv[n-k]
  end

  def c(n, k)
    return ModInt.zero if m < k
    return ModInt.zero if n < k
    return ModInt.zero if k < 0

    f[n] * finv[n-k] * finv[k]
  end

  # c(n,k) = c(n,n-k)
  # h(n,k) = c(n+k-1,n) = c(n+k-1,n+k-1-n) = c(n+k-1,k-1)
  # k種類から重複を許してn個取る
  # nを0個以上でk分割
  # k個の区別する箱に、区別しない球n個を入れる
  def h(k, n)
    c(n + k - 1, k - 1)
  end
end

struct Int
  MAX = 10_000_000
  class_getter ft : FactTable = FactTable.new(MAX)

  def f
    @@ft.f[self]
  end

  def finv
    @@ft.finv[self]
  end

  def p(k)
    @@ft.p(self,k)
  end

  def c(k)
    @@ft.c(self,k)
  end

  def h(k)
    @@ft.h(self,k)
  end
end
# F = (x + x^-1)^T = x^-T (x^2 + 1)^T = x^-T Σi,C(T i)x^2i = Σi,C(T i)x^2i-T
# 2i-T = a -> i = (a + T) // 2
def solve_1d(a, t)
  return 0.to_m if t < a
  cnt = a + t
  return 0.to_m if cnt.odd?
  t.c(cnt//2)
end

# F = (x + x^-1 + y + y^-1) = (xy)^-1 (x^2y + y + xy^2 + x) = (xy)^-1 (xy + 1)(x + y)
# F^T = (xy)^-T (xy + 1)^T (x + y)^T = (xy)^-T Σi Σj C(T i) C(T j) x^i+j-T y^i-j
# i + j - T = a && i - j = b
# 2i - T = a + b
#
# i = (a + b + T) // 2
# j = i - b
def solve_2d(a, b, t)
  return 0.to_m if t < a + b
  cnt = a + b + t
  return 0.to_m if cnt.odd?
  t.c(cnt//2) * t.c(cnt//2 - b)
end

n,x,y,z = gets.to_s.split.map(&.to_i64)
ans = 0.to_m
x,y,z = {x,y,z}.map(&.abs)

(0..n).each do |t|
  ans += solve_1d(z, t) * solve_2d(x, y, n - t) * n.c(t)
end

pp ans
