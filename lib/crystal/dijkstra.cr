class PriorityQueue(T)
  getter f : T, T -> Bool
  getter a : Deque(T)

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Deque(T).new
  end

  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Deque(T).new
  end

  def <<(v : T)
    @a << v
    fixup(a.size - 1)
  end

  def pop : T
    ret = a[0]
    last = a.pop
    if a.size > 0
      a[0] = last
      fixdown
    end
    ret
  end

  private def fixup(i : Int32)
    j = up(i)
    while i > 0 && comp j, i
      a.swap i, j
      i, j = j, up(j)
    end
  end

  private def fixdown
    i = 0
    while lo(i) < a.size
      if hi(i) < a.size && comp lo(i), hi(i)
        j = hi(i)
      else
        j = lo(i)
      end
      break if comp j, i
      a.swap i, j
      i = j
    end
  end

  @[AlwaysInline]
  private def comp(i, j)
    f.call a[i], a[j]
  end

  @[AlwaysInline]
  private def lo(i)
    i * 2 + 1
  end

  @[AlwaysInline]
  private def hi(i)
    i * 2 + 2
  end

  @[AlwaysInline]
  private def up(i)
    (i - 1) // 2
  end

  delegate :size, to: @a
end

INF = Int64::MAX

class Graph
  alias Edge = Tuple(Int32,Int64)
  getter n : Int32
  getter g : Array(Array(Edge))
  delegate "[]", to: @g
  
  def initialize(@n)
    @g = Array.new(n){ [] of Edge }
  end

  def reverse
    Graph.new(n).tap do |ans|
      n.times do |v|
        g[v].each do |nv, cost|
          ans[nv] << {v, cost}
        end
      end
    end
  end

  # from 1-indexed
  def add_edge(a,b,c)
    g[(a-1).to_i] << {(b-1).to_i, c.to_i64}
  end
  
  def dijkstra(init)
    q = PriorityQueue(Edge).new { |a, b| a.last > b.last }
    q << {init, 0_i64}
    
    seen = Array.new(n, false)
    costs = Array.new(n, INF)
    
    while q.size > 0
      v, cost = q.pop
      next if seen[v]
      seen[v] = true
      costs[v] = cost
      g[v].each do |nv, ncost|
        next if seen[nv]
        q << {nv, cost + ncost}
      end
    end
    return costs
  end
end
