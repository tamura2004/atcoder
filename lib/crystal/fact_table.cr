# 事前計算によりO(1)で二項係数を求める
#
class FactTable
  getter m : Int32
  getter f : Array(ModInt)
  getter finv : Array(ModInt)
  getter inv : Array(ModInt)

  def initialize(m)
    @m = m.to_i
    @f = [ModInt.new(1)]
    (1..m).each { |i| f << f.last * i }

    @finv = [f[m].inv]
    (1..m).each { |i| finv << finv.last * (m + 1 - i)}
    finv.reverse!

    @inv = [ModInt.new(1)]
    (1..m).each { |i| inv << finv[i] * f[i - 1]}
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

class Pw2Table
  getter m : Int32
  getter pw2 : Array(ModInt)

  def initialize(m)
    @m = m.to_i
    @pw2 = [ModInt.zero + 1]
    m.times do
      pw2 << pw2[-1] * 2
    end
  end
end

struct Int
  MAX = 1_000_000
  class_getter ft : FactTable = FactTable.new(MAX)
  class_getter pw2 : Pw2Table = Pw2Table.new(MAX)

  def f
    @@ft.f[self]
  end

  def inv
    @@ft.inv[self]
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

  def pow(k)
    # 2べきは頻度が多いので高速化
    if self == 2
      if k >= MAX
        to_m ** k
      elsif k >= 0
        @@pw2.pw2[k]
      else
        @@pw2.pw2[-k].inv
      end
    else
      if k >= 0
        to_m ** k
      else
        (to_m ** (-k)).inv
      end
    end
  end
end