# 累積和の更新と取得を共にO(log N)で行うデータ構造
#
# ```
# t = FenwickTree.new([1,2,3])
# t.sum(0) # => 0
# t.sum(1) # => 1
# t.sum(2) # => 3
# t.sum(3) # => 6
# t.add(2, 4)
# t.sum(0) # => 0
# t.sum(1) # => 1
# t.sum(2) # => 7
# t.sum(3) # => 10
# ```
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
    raise "FenewickTree#add: index #{i} must not be zero or negative" if i.sign != 1
    while i <= n
      data[i] += x
      i += ffs(i)
    end
  end
  
  # 要素1からiまでの累積和を取得
  def sum(i : Int)
    result = T.zero
    while i > T.zero
      result += data[i]
      i -= ffs(i)
    end
    result
  end

  # 2進数で1が出現する最下位ビット
  def ffs(i)
    i & -i
  end
end
