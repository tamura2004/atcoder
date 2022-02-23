require "crystal/modint9"

class FactTable
  K = 10_000_001
  class_getter f : Array(ModInt) = [] of ModInt
  class_getter finv : Array(ModInt) = [] of ModInt
  class_getter inv : Array(ModInt) = [] of ModInt

  def self.init
    f << 1.to_m
    (1..K).each { |i| f << f.last * i }

    finv << f[K].inv
    (1..K).each { |i| finv << finv.last * (K + 1 - i) }
    # finv << 1.to_m
    finv.reverse!

    inv << 1.to_m
    (1..K).each { |i| inv << finv[i] * f[i - 1] }
  end

  def self.p(n, k)
    return 0.to_m if n < k
    return 0.to_m if k < 0

    ans = 1.to_m
    k.times do |i|
      ans *= n - i
    end
    ans
  end

  def self.c(n, k)
    raise "overflow #{k}" if K < k
    return 0.to_m if n < k
    return 0.to_m if k < 0

    f[n] * finv[n-k] * finv[k]
  end

  # c(n,k) = c(n,n-k)
  # h(n,k) = c(n+k-1,n) = c(n+k-1,n+k-1-n) = c(n+k-1,k-1)
  def self.h(k, n)
    c(n + k - 1, k - 1)
  end
end

alias FT = FactTable
FT.init

struct Int
  def f
    FT.f[self]
  end

  def inv
    FT.inv[self]
  end

  def finv
    FT.finv[self]
  end

  def p(k)
    FT.p(self, k)
  end

  def c(k)
    FT.c(self, k)
  end

  def h(k)
    FT.h(self, k)
  end
end
