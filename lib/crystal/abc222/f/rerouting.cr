require "crystal/weighted_tree/tree"
require "crystal/indexable"
include WeightedTree

module Abc222
  module F
    struct Rerouting
      getter g : Tree
      delegate n, to: g
      getter d : Array(Int64)
      getter dp : Array(Array(Int64))
      getter left : Array(Array(Int64))
      getter right : Array(Array(Int64))
    
      def initialize(@g, @d)
        @dp = Array.new(n){ [] of Int64 }
        @left = Array.new(n){ [] of Int64 }
        @right = Array.new(n){ [] of Int64 }
      end
    
      def solve
        dfs1(0, -1)
      end
    
      def dfs1(v, pv)
        ans = d[v]
        g[v].each do |nv, cost|
          next if nv == pv
          dp[v] << dfs1(nv, v) + cost
          chmax ans, dp[v][-1]
        end

        left[v] = dp[v].csmax
        right[v] = dp[v].reverse.csmax.reverse

        ans
      end

      def dfs2(v, pv, cost)
        i = 0
        g[v].each do |nv, cost|
          next if nv == pv
          cnt = left[]

        end
      end
    end    
  end
end
