# 重み付きユニオンファインド木
class UnionFind
  attr_accessor :a, :h

  def initialize(n)
    # マイナスなら要素数、ゼロ以上なら親のインデックス
    @a = Array.new(n, -1)
    @h = Array.new(n, 0)
  end

  def find(i)
    a[i] < 0 ? i : (r = find(a[i]); h[i] += h[a[i]]; a[i] = r)
  end

  def same?(i, j)
    find(i) == find(j)
  end

  def size(i)
    -a[find(i)]
  end

  def weight(i)
    find(i)
    h[i]
  end

  def diff(i, j)
    weight(j) - weight(i)
  end

  def unite(i, j, w)
    w += weight(i)
    w -= weight(j)

    i = find(i)
    j = find(j)
    return if i == j

    if a[i] > a[j]
      i, j = j, i
      w = -w
    end

    a[i] += a[j]
    a[j] = i
    h[j] = w
  end
end
