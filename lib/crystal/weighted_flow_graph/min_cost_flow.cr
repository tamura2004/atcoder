require "crystal/weighted_flow_graph/graph"
require "crystal/priority_queue"

module WeightedFlowGraph
  class MinCostFlow
    getter g : Graph
    getter pv : Array(Int32)
    getter pe : Array(Int32)
    getter dual : Array(Int64)
    delegate :pos, :n, to: g
    
    def initialize(@g)
      @pv = Array(Int32).new(n, 0)
      @pe = Array(Int32).new(n, 0)
      @dual = Array(Int64).new(n, 0)
    end
  
    def solve(s, t, flow_limit = Int64::MAX)
      slope(s, t, flow_limit).last
    end
  
    def dual_ref(s, t)
      dist = Array.new(n, Int64::MAX)
      pv.fill(-1)
      pe.fill(-1)
      seen = Array(Bool).new(n, false)
  
      que = PriorityQueue(Tuple(Int64, Int32)).lesser
      dist[s] = 0_i64
      que << {0_i64, s}
  
      while que.size > 0
        d, v = que.pop
        next if seen[v]
  
        seen[v] = true
        break if v == t
  
        g[v].each_with_index do |e, i|
          nv, cap, cost = e.to, e.cap, e.cost
          next if seen[nv] || cap == 0
  
          n_cost = cost - dual[nv] + dual[v]
          next unless dist[nv] - dist[v] > n_cost
  
          dist[nv] = dist[v] + n_cost
          pv[nv] = v
          pe[nv] = i
          que << {dist[nv], nv}
        end
      end
  
      return false unless seen[t]
  
      n.times do |i|
        next unless seen[i]
  
        dual[i] -= dist[t] - dist[i]
      end
  
      true
    end
  
    def slope(s = 0, t = n - 1, flow_limit = Int64::MAX)
      s = s.to_i
      t = t.to_i

      flow = 0_i64
      cost = 0_i64
      prev_cost = -1
      result = [{flow, cost}]
  
      while flow < flow_limit
        break unless dual_ref(s, t)
  
        c = flow_limit - flow
        v = t
        while v != s
          c = g[pv[v]][pe[v]].cap if c > g[pv[v]][pe[v]].cap
          v = pv[v]
        end
  
        v = t
        while v != s
          e = g[pv[v]][pe[v]]
          e.cap -= c
          g[v][e.rev].cap += c
          v = pv[v]
        end
  
        d = -dual[s]
        flow += c
        cost += c * d
        result.pop if prev_cost == d
        result << {flow, cost}
        prev_cost = d
      end
  
      result
    end
  end
end
