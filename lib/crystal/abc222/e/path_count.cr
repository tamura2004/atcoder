require "crystal/edge_labeled_tree/tree"

module Abc222
  module E
    include EdgeLabeledTree

    struct PathCount
      getter g : Tree
      delegate n, to: g
      getter dp : Array(Int32)

      def initialize(@g)
        @dp = Array.new(n - 1, 0)
      end

      def solve(sv, gv)
        dfs(sv, -1, gv)
      end

      def dfs(v, pv, gv)
        return true if v == gv
        g[v].each do |nv, i|
          next if nv == pv
          next if !dfs(nv, v, gv)

          dp[i] += 1
          return true
        end
        false
      end
    end
  end
end
