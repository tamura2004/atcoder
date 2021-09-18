require "crystal/tree"
require "crystal/rbst"

module Abc218
  module G
    struct Rec
      getter t : Tree
      getter a : Array(Int64)
      getter rb : RBST(Int64)
      getter ans : Array(Int64)
      delegate n, to: t

      def initialize(@t,@a)
        @rb = RBST(Int64).new
        @ans = Array(Int64).new(n, -1_i64)
      end

      def solve
        dfs(0, -1)
        ans
      end

      def dfs(v, pv)
        rb << a[v]
        ans[v] = rb.median.not_nil!.to_i64

        t[v].each do |nv|
          next if nv == pv
          dfs(nv, v)
        end

        rb.delete(a[v])
      end
    end

    struct Solve
      getter t : Tree
      delegate n, to: t
      getter depth : Array(Int32)
      getter medians : Array(Int64)

      def initialize(@t,@depth,@medians)
      end

      def solve
        dfs(0, -1)
      end

      def dfs(v, pv)
        candi = [] of Int64

        t[v].each do |nv|
          next if nv == pv
          candi << dfs(nv, v)
        end

        if candi.empty?
          medians[v]
        else
          if depth[v].even?
            candi.max
          else
            candi.min
          end
        end
      end
    end
  end
end
