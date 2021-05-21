require "crystal/tree"

class Problem
  getter n : Int32
  getter g : Tree
  getter subtree_size : Array(Int32)
  getter parent : Array(Int32)
  getter removed : Array(Bool)
  getter centroids : Array(Int32)

  def initialize
    @n = gets.to_s.to_i
    @g = Tree.new(n)
    (n-1).times do
      a,b = gets.to_s.split.map(&.to_i)
      g.add a, b, both: true, origin: 1
    end

    # size of sub tree
    @subtree_size = Array.new(n, 0)
    @parent = Array.new(n, -1)
    @removed = Array.new(n, false)
    @centroids = [] of Int32
  end

  def dfs(v, size, pv = -1)
    subtree_size[v] = 1
    parent[v] = pv

    is_centroid = true

    g[v].each do |nv|
      next if nv == pv
      next if removed[v]
      dfs(nv, size, v)
      is_centroid = false if subtree_size[nv] > n // 2
      subtree_size[v] += subtree_size[nv]
    end

    is_centroid = false if n - subtree_size[v] > n // 2
    centroids << v if is_centroid
  end

  def solve
    subtrees = [] of Tuple(Int32,Int32)
    dfs(0, n)
    v = centroids[0]
    g[v].each do |nv|
      next if removed[nv]
      if parent[v] == nv
        subtrees << { nv, n - subtree_size[v] }
      else
        subtrees << { nv, subtree_size[nv] }
      end
    end
    return { v, subtrees }
  end
end

pr = Problem.new
pp pr.solve
