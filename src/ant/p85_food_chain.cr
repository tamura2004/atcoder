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

n,m = gets.to_s.split.map { |v| v.to_i }
uf = UnionFindTree.new(n*3)

ans = 0_i64
m.times do
  cmd,i,j = gets.to_s.split.map { |v| v.to_i }
  if i < 1 || n < i || j < 1 || n < j
    ans += 1
  else
    a_i = i
    b_i = i + n
    c_i = i + n * 2
    
    a_j = j
    b_j = j + n
    c_j = j + n * 2

    case cmd
    when 1
      if uf.same?(a_i, b_j) && uf.same?(a_i, c_j) && uf.same?(b_i, a_j) && uf.same?(b_i, c_j) && uf.same?(c_i, a_j) && uf.same?(c_i, a_j)
        ans += 1
      else
        uf.unite(a_i, a_j)
        uf.unite(b_i, b_j)
        uf.unite(c_i, c_j)
      end
    when 2
      if uf.same?(a_i, a_j) && uf.same?(a_i, c_j) && uf.same?(b_i, b_j) && uf.same?(b_i, a_j) && uf.same?(c_i, c_j) && uf.same?(c_i, b_j)
        ans += 1
      else
        uf.unite(a_i, b_j)
        uf.unite(b_i, c_j)
        uf.unite(c_i, a_j)
      end
    end
  end
end

puts ans

