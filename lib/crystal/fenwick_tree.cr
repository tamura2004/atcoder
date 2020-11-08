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
  def add(i : Int, x : T)
    raise ArgumentError.new("FenewickTree#add: index #{i} must not be zero or negative") if i.sign != 1
    while i <= n
      data[i] += x
      i += lsb(i)
    end
  end

  def []=(i : Int, x : T)
    add(i, x)
  end
  
  # 要素1からiまでの累積和を取得
  def sum(i : Int)
    result = T.zero
    while i > T.zero
      result += data[i]
      i -= lsb(i)
    end
    result
  end

  def [](i : Int)
    sum(i)
  end

  # 二分探索で合計がx以上になる最小のiを求める
  def bsearch(x : T)
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
  def lsb(i)
    i & -i
  end
end
