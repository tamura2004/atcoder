require "crystal/priority_queue"
require "crystal/abc204/e/graph"

module Abc204
  module E
    class Dijkstra
      getter g : Graph
      delegate n, to: g
      
      def initialize(@g)
      end

      private def cost(t, d)
        tt = Math.max t, Math.sqrt(d).to_i64
        # pp! tt
        d // (tt + 1) + (tt - t)
      end

      def solve
        seen = Array.new(n, false)
        # seen[0] = true XXXX
        pq = PriorityQueue(Tuple(Int64,Int32)).lesser
        pq << { 0_i64, 0 }

        while pq.size > 0
          t, v = pq.pop
          next if seen[v]
          seen[v] = true # <= OOO

          if v == n - 1
            puts t
            exit
          end

          g[v].each do |nv, c, d|
            next if seen[nv]
            # pp! t
            # pp! c
            # pp! d
            # pp! cost(t,d)
            pq << { t + c + cost(t, d), nv }
          end
        end

        return -1
      end
    end
  end
end
