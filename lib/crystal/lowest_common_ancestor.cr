# 最小共通祖先
require "crystal/tree"

class LowestCommonAncestor < Tree
  getter depth : Array(Int64)

  def initialize(@n)
    @depth = Array.new(n, 0_i64)
  end

  def calc
    bfs do |v, nv|
      depth[nv] = depth[v] + 1
    end
  end

  def solve(i, j)
  end
end

