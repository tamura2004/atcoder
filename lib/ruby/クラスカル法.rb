# クラスカル法
# edge = [cost,a,b]
# edges = [edge]
# a,b < n
def kruskal(n,edges)
  edges.sort!
  uf = UnionFind.new(n)
  edges.inject(0) do |ans,(cost,a,b)|
    break ans if uf.size(a) >= n
    next ans if uf.same?(a,b)
    uf.unite(a,b)
    ans += cost
  end
end
