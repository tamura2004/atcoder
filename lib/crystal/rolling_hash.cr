# ローリングハッシュによる部分列の検索
#
# ```
# # 文字列の場合
# s = RollingHash.new("0101")
# t = RollingHash.new("01")
# s[2,2] == t[0,2] # true
# s[1,2] == t[0,2] # false
#
# # 数値配列の場合
# s = RollingHash.new([0,1,0,1])
# t = RollingHash.new([0,1])
# s[2,2] == t[0,2] # true
# s[1,2] == t[0,2] # false
# ```
class RollingHash
  record ModInt, v : UInt128 do
    MOD = UInt128.new(2) << 61 - 1
    def +(b); ModInt.new((v + b.to_u128 % MOD) % MOD); end
    def -(b); ModInt.new((v + MOD - b.to_u128 % MOD) % MOD); end
    def *(b); ModInt.new((v * (b.to_u128 % MOD)) % MOD); end
    def self.zero; new(0); end
    def to_u128; v; end
  end

  getter hash : Array(ModInt)
  getter pow : Array(ModInt)
  getter n : Int32

  def initialize(s : Array(Int64))
    s = s.map(&.to_i64)
    @n = s.size
    @hash = Array(ModInt).new(n + 1, ModInt.zero)
    @pow = Array(ModInt).new(n + 1, ModInt.zero)
    pow[0] = ModInt.new(1)

    base = 10**9 + 7
    n.times do |i|
      pow[i + 1] = pow[i] * base
      hash[i + 1] = hash[i] * base + s[i]
    end
  end

  def initialize(s : String)
    initialize(s.chars.map(&.ord.to_i64))
  end

  def get(lo, hi)
    hash[hi] - hash[lo] * pow[hi - lo]
  end

  def [](i : Int32, len : Int32)
    get(i, i+len)
  end

  def [](r : Range(Int32?, Int32?))
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    get(lo, hi)
  end
end
