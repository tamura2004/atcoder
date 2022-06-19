require "crystal/priority_queue"
require "crystal/abstract_graph/graph"

module AbstractGraph
  class Dijkstra(V, E, S)
    getter g : Graph(V, E)
    getter nex : Proc(S,E,S)

    def initialize(@g, @nex : Proc(S,E,S))
    end

    def solve(init : S)
      dp = Hash(V, Int64).new(0_i64)
      seen = Hash(V, Bool).new(false)
      pq = PriorityQueue(S).lesser
      pq << init

      while pq.size > 0
        s = pq.pop
        next if seen[s.v]
        seen[s.v] = true
        dp[s.v] = s.cost

        g[s.v].each do |e|
          next if seen[e.nv]
          pq << nex.call(s,e)
        end
      end
      return dp
    end
  end
end
