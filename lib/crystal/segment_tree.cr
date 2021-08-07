# セグメント木
#
# 一点更新、区間計算をO(log n)で実行
# `T`: 要素の型
# 単位元: *unit* 省略時は`T.zero`を使用
# ```
# st = SegmentTree.new(4)
# st[1] = 10
# st[2] = 20
# st[1..2] # => 30
# ```
class SegmentTree(T)
  getter n : Int32
  getter unit : T
  getter xs : Array(T)
  getter fx : Proc(T, T, T)

  # 一点更新、区間加算、要素数で初期化
  def self.range_sum_query(n : Int32)
    new(n)
  end

  # 一点更新、区間加算、配列で初期化
  def self.range_sum_query(values : Array(T))
    new(values)
  end

  # 一点更新、区間最大、要素数で初期化
  def self.range_max_query(n : Int32)
    values = Array.new(n){ T.zero }
    new(values, unit: T.zero) do |x,y|
      Math.max(x,y)
    end
  end

  # 一点更新、区間最大、要素で初期化
  def self.range_max_query(values : Array(T))
    new(values, unit: T.zero) do |x,y|
      Math.max(x,y)
    end
  end

  # 一点更新、区間最小、要素数で初期化
  def self.range_min_query(n : Int32)
    values = Array.new(n){ T::MAX }
    new(values, unit: T::MAX) do |x,y|
      Math.min(x,y)
    end
  end

  # 一点更新、区間最小、要素で初期化
  def self.range_min_query(values : Array(T))
    new(values, unit: T::MAX) do |x,y|
      Math.min(x,y)
    end
  end

  # 一点更新、区間最小、要素で初期化
  def self.range_min_query(values : Array(T), unit : T)
    new(values, unit) do |x,y|
      Math.min(x,y)
    end
  end

  def initialize(n : Int32, init : T = T.zero)
    values = Array.new(n) { init }
    initialize(values)
  end

  def initialize(values : Array(T), unit : T = T.zero, &fx : Proc(T, T, T))
    initialize(values, unit, fx)
  end

  def initialize(
    values : Array(T),
    @unit : T = T.zero,
    @fx : Proc(T, T, T) = Proc(T, T, T).new { |x, y| x + y }
  )
    @n = Math.pw2ceil(values.size)
    @xs = Array(T).new(n*2, unit)

    values.each_with_index do |v, i|
      xs[i + n] = v
    end

    (n - 1).downto(1) do |i|
      xs[i] = fx.call xs[i << 1], xs[i << 1 | 1]
    end
  end

  def set(i : Int32, v : T)
    raise "Bad index i=#{i}" unless (0...n).includes?(i)

    i += n
    xs[i] = v
    while i > 1
      i >>= 1
      xs[i] = fx.call xs[i << 1], xs[i << 1 | 1]
    end
  end

  def []=(i : Int32, v : T)
    set(i, v)
  end

  def get(i : Int32) : T
    xs[i + n]
  end

  def [](i : Int32) : T
    get(i)
  end

  def sum(i : Int32, j : Int32) : T
    i = Math.max(i, 0)
    j = Math.min(j,n-1)

    i += n; j += n
    left = right = unit
    while i < j
      if i.odd?
        left = fx.call left, xs[i]
        i += 1
      end

      if j.odd?
        j -= 1
        right = fx.call xs[j], right
      end
      i >>= 1; j >>= 1
    end

    fx.call(left, right)
  end

  def [](r : Range(Int32?, Int32?)) : T
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    sum(lo, hi)
  end

  def bsearch(k : T) : Int32
    i = 1
    while i < n
      i <<= 1
      if xs[i] < k
        k -= xs[i]
        i |= 1
      end
    end
    return i - n
  end

  def pp
    puts "========"
    i = 1
    while i <= n
      sep = " " * ((n * 2) // i - 1)
      puts xs[i...(i << 1)].join(sep)
      i <<= 1
    end
    puts "--------"
  end
end
