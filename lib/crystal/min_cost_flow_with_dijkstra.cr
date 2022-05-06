require "crystal/priority_queue"

class Edge
  getter to : Int32
  getter rev : Int32
  property cap : Int64
  getter cost : Int64

  def initialize(@to, @rev, @cap, @cost)
  end
end

class Graph
  getter n : Int32
  getter g : Array(Array(Edge))
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n) { [] of Edge }
  end

  def add(v, nv, cap, cost, origin = 0)
    v = v.to_i - origin
    nv = nv.to_i - origin
    cap = cap.to_i64
    cost = cost.to_i64

    rev_v = g[v].size
    rev_nv = g[nv].size

    g[v] << Edge.new(nv, rev_nv, cap, cost)
    g[nv] << Edge.new(v, rev_v, 0_i64, -cost)
  end
end

class MinCostFlow
  getter g : Graph
  delegate n, to: g
  getter d : Array(Int64)
  getter h : Array(Int64)
  getter pv : Array(Int32)
  getter pe : Array(Int32)

  def initialize(@g)
    @d = Array.new(n, 0_i64)
    @h = Array.new(n, 0_i64)
    @pv = Array.new(n, 0)
    @pe = Array.new(n, 0)
  end

  def solve(s, t, f)
    res = 0_i64

    h.fill(0_i64)
    count = 0
    while f > 0
      count += 1

      # pp! ({Time.local, count})
      q = PQ(Tuple(Int64, Int32)).lesser
      d.fill(Int64::MAX)
      d[s] = 0_i64
      q << {0_i64, s}

      while q.size > 0
        cost, v = q.pop
        next if d[v] > cost

        g[v].each_with_index do |e, i|
          nv, rev, cap, cost = e.to, e.rev, e.cap, e.cost
          n_cost = d[v] + cost + h[v] - h[nv]
          if cap > 0 && d[nv] > n_cost
            d[nv] = n_cost
            pv[nv] = v
            pe[nv] = i
            q << {n_cost, nv}
          end
        end
      end

      return -1_i64 if d[t] == Int64::MAX
      n.times { |u| h[u] += d[u] }

      # path = [] of Int32
      # rev_path = uninitialized Proc(Int32,Nil)
      # rev_path = -> (v : Int32) do
      #   return if v == s
      #   path << v
      #   rev_path.call(pv[v])
      # end
      # rev_path.call(t)

      # pp! path

      # x = path.min_of do |v|
      #   g[pv[v]][pe[v]].cap
      # end
      # x = Math.min x, f

      x = f
      u = t
      while u != s
        x = Math.min(x, g[pv[u]][pe[u]].cap)
        u = pv[u]
      end

      f -= x
      res += x * h[t]

      # path.each do |v|
      #   e = g[pv[v]][pe[v]]
      #   e.cap -= x
      #   g[v][e.rev].cap += x
      # end
      u = t
      while u != s
        e = g[pv[u]][pe[u]]
        e.cap -= x
        g[u][e.rev].cap += x

        u = pv[u]
      end
    end
    res
  end
end
