# 座標圧縮付セグ木
#
# ```
# key => valueペアにおいて、keyが大きく稠密でないとき
# 内部で座標圧縮してセグ木を利用する。
# クエリ先読みをして予めkeyを設定する。
# 初期値が有る場合はvaluesとして与える。
# 初期値が無ければ、ゼロ値で初期化される。
#
# A = 100_000_000_i64
# B = 200_000_000_i64
# C = 300_000_000_i64
# D = 400_000_000_i64
# keys = [A, B, C, D]
# values = [1, 2, 3, 4]
# st = CCST.new(keys, values, unit: 0) { |x,y| x + y }
# st[B..C] # => 5
# st[B] = 7
# st[B..C] # => 10
# ```
class CoodinateCompressSegmentTree(K, V)
  getter n : Int32
  getter ref : Array(K)
  getter a : Array(V)
  getter fx : Proc(V, V, V)
  getter unit : V

  def self.range_min_query(keys : Array(K), values : Array(V))
    unit = V::MAX
    fx = Proc(V, V, V).new do |a, b|
      Math.min(a, b)
    end
    new(keys, values, unit, fx)
  end

  def self.range_min_query(keys : Array(K))
    values = keys.map { Int64::MAX }
    unit = Int64::MAX
    fx = Proc(Int64, Int64, Int64).new do |a, b|
      Math.min(a, b)
    end
    new(keys, values, unit, fx)
  end

  def self.range_max_query(keys : Array(K), values : Array(V))
    unit = V::MIN
    fx = Proc(V, V, V).new do |a, b|
      Math.max(a, b)
    end
    new(keys, values, unit, fx)
  end

  def self.range_max_query(keys : Array(K))
    values = keys.map { Int64::MIN }
    unit = Int64::MIN
    fx = Proc(Int64, Int64, Int64).new do |a, b|
      Math.max(a, b)
    end
    new(keys, values, unit, fx)
  end

  def initialize(
    keys : Array(K),
    values : Array(V) = keys.map { V.zero },
    unit : V = V.zero,
    &fx : Proc(V, V, V)
  )
    initialize(keys, values, unit, fx)
  end

  def initialize(hash : Hash(K,V), unit : V, &fx : Proc(V,V,V))
    initialize(hash.keys, hash.values, unit, fx)
  end

  def initialize(
    keys : Array(K),
    values : Array(V) = keys.map { V.zero },
    @unit : V = V.zero,
    @fx : Proc(V, V, V) = Proc(V, V, V).new { |x, y| x + y }
  )
    @ref = keys.sort.uniq
    ref << K::MAX
    @n = ref.size
    @a = Array.new(n*2, unit)

    values.each_with_index do |v, i|
      j = index(keys[i]) + n
      a[j] = v
    end

    (n - 1).downto(1) do |i|
      a[i] = fx.call a[i << 1], a[i << 1 | 1]
    end
  end

  def index(x : K) : Int32
    ref.bsearch_index do |i|
      x <= i
    end || n
  end

  def set(x : K, v : V)
    i = index(x) + n
    a[i] = v
    while i > 1
      i >>= 1
      a[i] = fx.call a[i << 1], a[i << 1 | 1]
    end
  end

  def []=(x : K, v : V)
    set(x, v)
  end

  # x 以上の最小のキーの値
  def get_upper(x : K) : V
    i = index(x) + n
    a[i]
  end

  def [](x : K) : V
    get_upper(x)
  end

  def sum(x : K, y : K) : V
    i = index(x) + n
    j = index(y) + n
    lo = hi = unit
    while i < j
      (lo = fx.call lo, a[i]; i += 1) if i & 1 == 1
      (j -= 1; hi = fx.call a[j], hi) if j & 1 == 1
      i >>= 1; j >>= 1
    end
    fx.call lo, hi
  end

  def [](r : Range(K?, K?)) : V
    lo = r.begin || K::MIN
    hi = (r.end || K::MAX - 1) + (r.excludes_end? ? 0 : 1)
    sum(lo, hi)
  end
end

alias CCST = CoodinateCompressSegmentTree
