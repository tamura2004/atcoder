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

# 題意に沿った辺の作成の例
# 平面上の座標、コストはユークリッド距離
# 色が異なる場合、コストは10倍
def make_edge(towers,i,j)
  xi,yi,ci = towers[i]
  xj,yj,cj = towers[j]
  cost = (xi - xj) ** 2 + (yi - yj) ** 2
  cost = Math.sqrt(cost.to_f)
  cost *= 10 if ci != cj
  [cost, i, j]
end