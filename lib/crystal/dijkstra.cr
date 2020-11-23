record Edge, to : Int32, cost : Int64

class Dijkstra(E)
  getter n : Int32
  getter g : Array(Array(E))

  def initialize(@g)
    @n = g.size
  end

  def dijkstra(init)
    q = PriorityQueue(E).new { |a, b| a.cost > b.cost }
    q << E.new(to: init, cost: 0)

    seen = Array.new(n, false)
    depth = Array.new(n, Int64::MAX)
  
    while q.size > 0
      e = q.pop
      v = e.to
      cost = e.cost

      next if seen[v]
      seen[v] = true
      depth[v] = cost
      
      g[v].each do |ne|
        nv = ne.to
        ncost = ne.cost
        next if seen[nv]
        q << E.new(to: nv, cost: cost + ncost)
      end
    end
    return depth
  end
end
