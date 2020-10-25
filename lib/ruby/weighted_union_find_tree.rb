class WeightedUnionFindTree
  def initialize(n)
    @par = Array.new(n, &:itself)
    @rank = Array.new(n, 0)
    @diff_weight = Array.new(n, 0)
  end

  def find(x)
    return x if @par[x] == x
    r = find(@par[x])
    @diff_weight[x] += @diff_weight[@par[x]]
    return @par[x] = r
  end

  def weight(x)
    find(x)
    return @diff_weight[x]
  end

  def same?(x, y)
    return find(x) == find(y)
  end

  def unite(x, y, w)
    w += weight(x)
    w -= weight(y)
    x = find(x)
    y = find(y)
    return false if x == y
    x, y, w = y, x, -w if @rank[x] < @rank[y]
    @rank[x] += 1 if @rank[x] == @rank[y]
    @par[y] = x
    @diff_weight[y] = w
    return true
  end

  def diff(x, y)
    weight(y) - weight(x)
  end
end
