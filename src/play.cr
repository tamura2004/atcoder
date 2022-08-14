class UnionFind
  getter n : Int32
  getter pa : Array(Int32)
  getter sz : Array(Int64)

  def initialize(n)
    @n = n.to_i
    @pa = Array.new(@n, &.itself)
    @sz = Array.new(@n, 1_i64)
  end

  def root(v)
    pa[v] = v == pa[v] ? v : root(pa[v])
  end

  def same?(v, nv)
    root(v) == root(nv)
  end

  def unite(v, nv)
    v = root(v)
    nv = root(nv)
    return if v == nv
    sz[nv] += sz[v]
    pa[v] = nv
  end

  def size(v)
    sz[root(v)]
  end
end

n,m,e = gets.to_s.split.map(&.to_i)

edges = Array.new(e) do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  chmin v, n
  chmin nv, n
  {v, nv}
end

q = gets.to_s.to_i64
x = Array.new(q) { gets.to_s.to_i.pred }
seen = x.to_set

uf = UnionFind.new(n+1)

edges.each_with_index do |(v,nv),i|
  next if i.in?(seen)
  uf.unite v, nv
end

ans = Array.new(q, 0_i64)
(0...q).reverse_each do |i|
  v, nv = edges[x[i]]
  ans[i] = uf.size(n) - 1
  uf.unite(v, nv)
end

puts ans.join("\n")