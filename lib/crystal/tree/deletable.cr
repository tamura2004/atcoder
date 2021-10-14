require "crystal/tree/parent"
require "crystal/tree/depth"

class Deletable
  getter g : Tree
  delegate n, to: g
  getter dead : Array(Bool)
  getter parent : Array(Int32)
  getter costs : Array(Int32)
  getter ord : Array(Int32)
  getter redo : Array(Int32)

  def initialize(@g, root = 0)
    @dead = Array.new(n, false)
    @parent = Parent.new(g).solve(root)
    @costs = Depth.new(g).solve(root).map(&.succ)
    @ord = costs.zip(0..).sort.map(&.last)
    @redo = [] of Int32
  end

  def min(m)
    return 0_i64 if m == 0
    return Int64::MAX if ord.size < m
    ans = 0_i64
    cnt = 0
    ord.each do |v|
      next if dead[v]
      ans += costs[v]
      cnt += 1
      break if cnt == m
    end
    ans
  end
  
  def max(m)
    return 0_i64 if m == 0
    return Int64::MIN if ord.size < m
    ans = 0_i64
    cnt = 0 
    ord.reverse_each do |v|
      next if dead[v]
      ans += costs[v]
      cnt += 1
      break if cnt == m
    end
    ans
  end

  # to_a
  def to_a(root = 0)
    ans = [] of Int32
    dfs(root, -1, ans)
    ans
  end

  def dfs(v, pv, ans)
    return if dead[v]
    ans << v

    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v, ans)
    end
  end

  def delete(v)
    @redo.clear
    dfs2(v, parent[v])
  end

  def dfs2(v, pv)
    dead[v] = true
    redo << v
    g[v].each do |nv|
      next if nv == pv
      next if dead[nv]
      dfs2(nv, v)
    end
  end
  
  def rollback
    redo.each do |v|
      dead[v] = false
    end
  end
end
