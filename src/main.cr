require "crystal/mod_int"

class FactTable
  K = 200_001
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

    f[n] * finv[n-k]
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

h,w,n = gets.to_s.split.map(&.to_i)
rc = Array.new(n) do
  Tuple(Int32,Int32).from gets.to_s.split.map(&.to_i.pred)
end

rc << {0,0}
rc <<{h-1,w-1}
rc.sort!

dp = make_array(0.to_m, n + 2, 2)
dp[0][1] = 1.to_m

(1..n+1).each do |i|
  y,x = rc[i]
  (0...i).each do |j|
    py,px = rc[j]
    next unless px <= x

    2.times do |pa|
      b = y - py
      a = b + x - px

      dp[i][1-pa] += dp[j][pa] * a.c(b)
    end
  end
end

ans = 0.to_m
(1..n+1).each do |i|
  2.times do |pa|
    if pa.even?
      ans += dp[i][pa]
    else
      ans -= dp[i][pa]
    end
  end
end

ans = dp[-1][0] - dp[-1][1]
pp ans