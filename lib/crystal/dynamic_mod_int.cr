# 動的ModInt
# modは素数
struct ModInt
  class_getter mod : Int64 = 998_244_353_i64
  class_getter maxi : Int64 = 1_000_000_i64
  class_getter fact : Array(ModInt) = [1.to_m]
  class_getter finv : Array(ModInt) = [] of ModInt
  class_getter inv : Array(ModInt) = [] of ModInt
  getter v : Int64
  delegate to_i64, to_m, to_s, inspect, to: v

  # 剰余の法の変更
  def self.mod=(mod)
    @@mod = mod.to_i64
    self.maxi = Math.min(mod - 1, maxi)
  end

  # 階乗の事前計算の最大値
  def self.maxi=(maxi)
    @@maxi = Math.min(mod - 1, maxi.to_i64)
    init
  end

  # 階乗テーブルの事前計算
  def self.init
    @@fact = [1.to_m] if 1 < fact.size
    maxi.times do |i|
      fact << fact[-1] * (i + 1)
    end
    @@finv = [fact[-1].inv]
    maxi.times do |i|
      finv << finv[-1] * (maxi - i)
    end
    finv.reverse!
    @@inv = [0.to_m] if 1 < inv.size
    maxi.times do |i|
      inv << fact[i] * finv[i-1]
    end
  end

  # コンストラクタ
  def initialize(v)
    @v = v.to_i64 % @@mod
  end

  # 加減乗
  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      ModInt.new v {{op.id}} (b.to_i64 % @@mod)
    end
  {% end %}

  def succ
    ModInt.new(self + 1)
  end
  
  def pred
    ModInt.new(self - 1)
  end

  def //(b)
    self * b.to_m.inv
  end

  # 累乗
  def pow(b)
    a = self
    ans = 1.to_m
    while b > 0
      if b.odd?
        ans *= a
      end
      b //= 2
      a *= a
    end
    ans
  end

  # モジュラ逆数
  def inv
    a = to_i64
    b = @@mod
    x, y, u, v = 1_i64, 0_i64, 0_i64, 1_i64
    while !b.zero?
      k = a // b
      x -= k * u
      y -= k * v
      x, u = u, x
      y, v = v, y
      a, b = b, a % b
    end
    ModInt.new(x)
  end

  def ==(b)
    b.try &.to_i64.==(v)
  end

  def self.zero
    ModInt.new(0_i64)
  end
end

struct Int
  def to_m
    ModInt.new(to_i64)
  end

  def to_mod
    ModInt.mod = to_i64
  end

  def to_maxi
    ModInt.maxi = to_i64
  end

  def fact
    ModInt.fact[self]
  end

  def finv
    ModInt.finv[self]
  end

  def inv
    return ModInt.inv[self] if self < ModInt.inv.size
    ModInt.new(to_i64).inv
  end

  def c(k)
    return 0.to_m if ModInt.mod < k
    return 0.to_m if self < k
    return 0.to_m if k < 0
    fact * (self - k).finv * k.finv
  end
end
