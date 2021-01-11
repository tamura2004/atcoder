class UnionFindTree
  getter n : Int32
  getter a : Array(Int32)
  getter b : Array(Int32)

  def initialize(@n)
    @a = Array.new(n, -1)
    @b = Array.new(n, 0)
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

  def unite(i, j)
    i = find(i)
    j = find(j)
    if i == j
      b[i] += 1
      return
    end
    i, j = j, i if a[i] > a[j]
    a[i] += a[j]
    a[j] = i
    b[i] += b[j] + 1
  end
  
  def gsize
    n.times.map{|i|find(i)}.uniq.size
  end
end

n = gets.to_s.to_i
uf = UnionFindTree.new(n)
n.times do
  a,b = gets.to_s.split.map { |v| v.to_i - 1 }
  uf.unite(a,b)
end

