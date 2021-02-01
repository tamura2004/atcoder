# 重み付きユニオンファインド木
# グラフの連結成分ごとの頂点と辺の数
#
# ```
# a = [{1,1},{1,2},{2,2},{3,3}] 
# => 1を含む部分グラフの頂点2,辺3
# uf = UnionFindTree.new(4)
# a.each do |i,j|
#   uf.unite(i,j)
# end
# uf.size(1) # => 2 
# uf.weight(1) # => 3 
#
# ```
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

n,m,r = gets.to_s.split.map { |v| v.to_i }
a = Array.new(r) do
  gets.to_s.split.map { |v| v.to_i }
end
a.sort_by!(&.last).reverse!

uf = UnionFindTree.new(n+m)
ans = 0_i64
a.each do |(x,y,cost)|
  y += m
  next if uf.same?(x,y)
  ans += cost  
  uf.unite(x,y)
end

puts 10000 * (n + m) - ans

