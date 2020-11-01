class UnionFindTree
  getter n : Int32
  getter a : Array(Int32)

  def initialize(@n)
    @a = Array.new(n, -1)
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
    return if i == j
    i, j = j, i if a[i] > a[j]
    a[i] += a[j]
    a[j] = i
  end
  
  def gsize
    n.times.map{|i|find(i)}.uniq.size
  end
end