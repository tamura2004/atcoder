require "./union_find_tree"
include Random::Secure

module Test
  class Tree
    getter n : Int32
    getter g : Array(Array(Int32))

    def initialize(@n)
      @g = Array.new(n){ [] of Int32 }
    end

    def rand
      uf = UnionFindTree.new(n)
      cnt = n - 1
      while cnt > 0
        a = rand(n)
        b = rand(n)
        next if uf.same?(a,b)
        uf.unite(a,b)
        g[a] << b
        g[b] << a
        cnt -= 1
      end
      self
    end

    def bfs(init)
      depth = Array.new(g.size, -1)
      depth[init] = 0
      que = [init]
      while que.size > 0
        v = que.pop
        yield v, depth[v]
        g[v].each do |nv|
          next if depth[nv] != -1
          depth[nv] = depth[v] + 1
          que << nv 
        end
      end
    end

    def to_s(root = 0)
      ans = ["@n = #{n}"]
      ans << "@g ="
      bfs(0) do |v,depth|
        ans << ("  " * depth) + "|- " + v.to_s
      end
      ans.join("\n")
    end
  end
end