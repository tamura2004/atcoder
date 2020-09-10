macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

class Edge
  property to : Int32
  property cap : Int32
  property cost : Int32
  property rev : Int32

  def initialize(@to, @cap, @cost, @rev)
  end
end

INF = Int32::MAX

class MinCostFlow
  getter n : Int32
  getter g : Array(Array(Edge))
  getter dist : Array(Int32)
  getter prevv : Array(Int32)
  getter preve : Array(Int32)

  def initialize(@n)
    @g = Array.new(n) { [] of Edge }
    @dist = Array.new(n, 0)
    @prevv = Array.new(n, 0)
    @preve = Array.new(n, 0)
  end

  def add_edge(from, to, cap, cost)
    g[from] << Edge.new(to, cap, cost, g[to].size)
    g[to] << Edge.new(from, 0, -cost, g[from].size - 1)
  end

  def min_cost_flow(s, t, f)
    res = 0
    while f > 0
      dist.fill(INF)
      dist[s] = 0
      update = true
      while update
        update = false
        n.times do |i|
          next if dist[i] == INF
          g[i].each_with_index do |e, j|
            if e.cap > 0 && dist[e.to] > dist[i] + e.cost
              dist[e.to] = dist[i] + e.cost
              prevv[e.to] = i
              preve[e.to] = j
              update = true
            end
          end
        end
      end

      return -1 if dist[t] == INF

      d = f
      v = t
      while v != s
        chmin d, g[prevv[v]][preve[v]].cap
        v = prevv[v]
      end
      f -= d
      res += d * dist[t]
      v = t
      while v != s
        e = g[prevv[v]][preve[v]]
        e.cap -= d
        g[v][e.rev].cap += d
        v = prevv[v]
      end
    end
    res
  end
end