# 座標圧縮（1次元）計算量 O(N logN)
#
# ```
# cc = CoodinateCompressLiner(Int32).new([100, -10, 5, -10])
# cc.src # => [100, -10, 5, -10]
# cc.dst # => [2, 0, 1, 0]
# cc.ref # => [-10, 5, 100]
# ```
class CoodinateCompressLiner(T)
  getter src : Array(T)
  getter dst : Array(Int32)
  getter ref : Array(T)

  def initialize(@src)
    @ref = src.sort.uniq
    @dst = src.map do |i|
      ref.bsearch_index do |j|
        i <= j
      end || 0
    end
  end

  def self.from_pair(p : Array(Tuple(T, T)))
    n = p.size
    ccl = new(p.map(&.first) + p.map(&.last))
    a = ccl.dst[0, n]
    b = ccl.dst[n, n]
    return a.zip(b)
  end
end

alias CCL = CoodinateCompressLiner(Int64)

class UnionFindTree
  getter n : Int32
  getter a : Array(Int32)
  getter w : Array(Int32) # 辺の数

  def initialize(@n)
    @a = Array.new(n, -1)
    @w = Array.new(n, 0)
  end

  def find(i)
    a[i] < 0 ? i : (a[i] = find(a[i]))
  end

  def same?(i, j)
    find(i) == find(j)
  end

  def size(i)
    -a[find(i)]
  end

  # 辺の数
  def weight(i)
    w[find(i)]
  end

  def unite(i, j)
    i = find(i)
    j = find(j)
    if i == j
      w[i] += 1
      return
    end
    i, j = j, i if a[i] > a[j]
    a[i] += a[j]
    a[j] = i
    w[i] += w[j] + 1
  end

  def gsize
    n.times.map{|i|find(i)}.uniq.size
  end
end

n = gets.to_s.to_i
src = Array.new(n) do
  a,b = gets.to_s.split.map { |v| v.to_i64 }
  {a,b}
end

dst = CCL.from_pair(src)
uf = UnionFindTree.new(n*2)
dst.each do |i,j|
  uf.unite(i,j)
end

seen = Array.new(n*2, false)
ans = 0_i64
(n*2).times do |i|
  j = uf.find(i)
  next if seen[j]
  seen[j] = true
  ans += Math.min uf.size(i), uf.weight(i)
end

puts ans