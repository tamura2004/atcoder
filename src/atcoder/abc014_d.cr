require "crystal/graph/dfs_tree"
require "crystal/tree/hl_sort"
require "crystal/tree/in_order_tree"

class HLDecomposition
  getter g : Tree
  delegate n, to: g
  getter ord : Array(Int32)
  getter vid : Array(Int32)
  getter head : Array(Int32)
  getter pa : Array(Int32)

  def initialize(@g, root = 0)
    # @g = DFSTree.new(_g).solve(root)
    HLSort.new(g).solve(root)
    @g, @ord, @vid, @pa = InOrderTree.new(g).solve(root)
    @head = Array.new(n, -1)
  end

  def solve
    dfs(vid[0])
    {g, ord, vid, head, pa}
  end

  def dfs(v)
    g[v].each do |nv|
      head[nv] = nv == g[v][0] ? head[v] : nv
      dfs(nv)
    end
  end
end

class LCA
  getter g : Tree
  getter ord : Array(Int32)
  getter vid : Array(Int32)
  getter head : Array(Int32)
  getter pa : Array(Int32)
  delegate n, to: g

  def initialize(@g, root = 0)
    @g, @ord, @vid, @head, @pa = HLDecomposition.new(g, root).solve
  end

  def solve(v, nv)
    v = vid[v]
    nv = vid[nv]

    while head[v] != head[nv]
      v, nv = nv, v unless head[v] < head[nv]
      nv = pa[head[nv]]
    end
    v < nv ? ord[v] : ord[nv]
  end
end

class Depth
  getter g : Graph
  delegate n, to: g
  getter depth : Array(Int32)

  def initialize(@g)
    @depth = Array.new(n, -1)
  end

  def solve(root = 0)
    depth[root] = 0
    dfs(root)
    depth
  end

  def dfs(v)
    g[v].each do |nv|
      next if depth[nv] != -1
      depth[nv] = depth[v] + 1
      dfs(nv)
    end
  end
end

n = gets.to_s.to_i
g = Graph.new(n)

(n - 1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

depth = Depth.new(g).solve
tree = DFSTree.new(g).solve
lca = LCA.new(tree)

q = gets.to_s.to_i
q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  u = lca.solve(v, nv)
  ans = depth[v] + depth[nv] - depth[u] * 2
  pp ans.succ
end
