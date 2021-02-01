class FenwickTree(T)
  getter n : Int32
  getter data : Array(T)

  # 要素数nで初期化
  def initialize(@n : Int32)
    @data = Array(T).new(n + 1, T.zero)
  end

  # 配列aで初期化
  def initialize(a : Array(T))
    @n = a.size
    initialize(n)
    a.each_with_index do |v, i|
      add(i + 1, v)
    end
  end

  # 要素iに加算
  def add(i : Int32, x : T)
    raise ArgumentError.new("FenwickTree#add: index #{i} must not be zero or negative") if i.sign != 1
    while i <= n
      data[i] += x
      i += lsb(i)
    end
  end

  def []=(i : Int32, x : T)
    add(i, x)
  end

  # 要素1からiまでの累積和を取得
  def sum(i : Int32) : T
    return T.zero if i <= 0
    result = T.zero
    while i > 0
      result += data[i]
      i -= lsb(i)
    end
    result
  end

  def [](i : Int32) : T
    sum(i)
  end

  # 二分探索で合計がx以上になる最小のiを求める
  def bsearch(x : T) : Int32
    return 0 if x <= 0
    return n + 1 if sum(n) < x
    i = 0
    w = 2 ** Math.log2(n).to_i
    while w > 0
      if i + w < n && data[i + w] < x
        x -= data[i + w]
        i += w
      end
      w //= 2
    end
    return i + 1
  end

  # 2進数で1が出現する最下位ビット
  def lsb(i) : Int32
    i & -i
  end
end

# 非負整数の配列aの転倒数
def inversion_number(a)
  n = a.max.to_i
  ft = FenwickTree(Int64).new(n+1)
  a.sum do |i|
    ft[i] = 1
    ft[n] - ft[i]
  end
end