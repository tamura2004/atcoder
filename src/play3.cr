class Tree
  getter n : Int32
  getter g : Array(Array(Int32))
  getter size : Array(Int32)

  def initialize(@n)
    @g = Array.new(n){ [] of Int32 }
    @size = [0] * n

    (n-1).times do |i|
      g[i] << i + 1
      g[i+1] << i
    end
  end

  def dfs_start
    size.fill(0)
    dfs(0,-1)
  end

  def dfs(v,pv)
    size[v] = 1
    g[v].each do |nv|
      next if nv == pv

      dfs(nv,v)
      size[v] += size[nv]
    end
  end

  def self_dfs
    size.fill(0)
    dfs = uninitialized Int32, Int32 -> Nil
    dfs = -> (v : Int32, pv : Int32) do
      size[v] = 1
      g[v].each do |nv|
        next if nv == pv

        dfs.call(nv, v)
        size[v] += size[nv]
      end
    end
    dfs.call(0, -1)
  end
end

g = Tree.new(100_000)

g.dfs_start
pp g.size[0]

g.self_dfs
pp g.size[0]
