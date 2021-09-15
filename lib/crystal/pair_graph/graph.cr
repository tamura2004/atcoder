# 頂点がTuple(Int32,Int32)であるグラフ
module PairGraph
  alias Pair = Tuple(Int32, Int32)

  class Graph
    getter g : Hash(Pair, Array(Pair))
    getter both : Bool
    delegate "[]", to: g

    def initialize(@both = true)
      @g = Hash(Pair, Array(Pair)).new { |h, k| h[k] = [] of Pair }
    end

    def add(vy, vx, nvy, nvx)
      g[{vy, vx}] << {nvy, nvx}
      g[{nvy, nvx}] << {vy, vx} if both
    end
  end

  struct ShortestDepth
    getter g : Graph

    def initialize(@g)
    end

    def solve(root)
      seen = Set(Pair).new
      seen << root

      depth = Hash(Pair, Int32).new
      depth[root] = 0

      q = Deque.new([root])

      while q.size > 0
        v = q.shift
        g[v].each do |nv|
          next if nv.in?(seen)
          seen << nv

          depth[nv] = depth[v] + 1
          q << nv
        end
      end

      depth
    end
  end
end