class Graph
  getter g : Array(Array(Int32))
  getter n : Int32
  delegate "[]", to: g

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n) { [] of Int32 }
  end

  def add(v, nv, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v if both
  end
end

class DFSTree
  getter g : Graph
  getter gg : Graph
  getter seen : Set(Int32)
  delegate n, to: g

  def initialize(@g)
    @seen = Set(Int32).new
    @gg = Graph.new(n)
  end

  def solve(root = 0)
    seen << root
    dfs(root)
    gg
  end

  def dfs(v)
    g[v].each do |nv|
      next if nv.in?(seen)
      seen << nv
      gg[v] << nv
      dfs(nv)
    end
  end
end

class InOrderTree
  getter g : Graph
  getter ord : Array(Int32)
  getter pa : Array(Int32)
  delegate n, to: g

  def initialize(@g)
    @ord = [] of Int32
    @pa = Array.new(n, -1)
  end

  def solve(root = 0)
    @g = DFSTree.new(g).solve(root)
    dfs(root, -1)
    vid = ord.zip(0..).sort.map(&.last)
    gg = Graph.new(n)

    n.times do |v|
      g[v].each do |nv|
        next if vid[v] > vid[nv]
        gg.add vid[v], vid[nv], origin: 0, both: false
        pa[vid[nv]] = vid[v]
      end
    end

    {gg, ord, vid, pa}
  end

  def dfs(v, pv)
    ord << v
    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v)
    end
  end
end

class SubTreeSize
  getter g : Graph
  delegate n, to: g
  getter ans : Array(Int32)

  def initialize(@g)
    @ans = Array.new(n, 0)
  end

  def dfs(v, pv)
    ans[v] = 1
    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v)
      ans[v] += ans[nv]
    end
  end

  def solve(root = 0)
    dfs(root, -1)
    ans
  end
end

class HLSort
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0)
    ss = SubTreeSize.new(g).solve(root)

    n.times do |v|
      g[v].sort_by! do |nv|
        -ss[nv]
      end
    end
  end
end

class HLDecomposition
  getter g : Graph
  delegate n, to: g
  getter head : Array(Int32)

  def initialize(@g)
    @head = Array.new(n, -1)
  end

  def solve(root = 0)
    @g, ord, vid, pa = InOrderTree.new(g).solve(root)
    HLSort.new(g).solve(vid[root])
    dfs(vid[root])
    {g, ord, vid, head, pa}
  end

  def dfs(v)
    g[v].each do |nv|
      # pp! [v,nv]
      head[nv] = nv == g[v][0] ? head[v] : nv
      dfs(nv)
    end
  end
end

class LCA
  getter g : Graph
  getter gg : Graph
  getter ord : Array(Int32)
  getter vid : Array(Int32)
  getter head : Array(Int32)
  getter pa : Array(Int32)
  delegate n, to: g

  def initialize(@g, root = 0)
    @gg, @ord, @vid, @head, @pa = HLDecomposition.new(g).solve(root)
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
lca = LCA.new(g)

q = gets.to_s.to_i
q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  u = lca.solve(v, nv)
  ans = depth[v] + depth[nv] - depth[u] * 2
  pp ans.succ
end
