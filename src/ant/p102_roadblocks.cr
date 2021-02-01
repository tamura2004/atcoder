class PriorityQueue(T)
  getter f : T, T -> Bool
  # getter sum : T
  getter a : Deque(T)

  forward_missing_to a

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Deque(T).new
    # @sum = T.zero
  end

  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Deque(T).new
    # @sum = T.zero
  end

  def <<(v : T)
    # @sum += v
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
    # @sum -= ret
    ret
  end

  def fixup(i : Int32)
    j = up(i)
    while i > 0 && comp j, i
      a.swap i, j
      i, j = j, up(j)
    end
  end

  def fixdown
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

  def comp(i, j)
    f.call a[i], a[j]
  end

  def lo(i)
    i * 2 + 1
  end

  def hi(i)
    i * 2 + 2
  end

  def up(i)
    (i - 1) // 2
  end
end

record Edge, from : Int32, to : Int32, cost : Int64
INF = Int64::MAX

class Graph(E)
  getter n : Int32
  getter g : Array(Array(E))

  def self.read
    n,m = gets.to_s.split.map { |v| v.to_i }
    g = Array.new(n){ [] of E }
    m.times do
      i,j,cost = gets.to_s.split.map { |v| v.to_i }
      i -= 1
      j -= 1
      g[i] << E.new(i, j, cost.to_i64)
      g[j] << E.new(j, i, cost.to_i64)
    end
    new(g)
  end

  def initialize(@g)
    @n = g.size
  end

  def dijkstra(init)
    q = PriorityQueue(E).new { |a, b| a.cost > b.cost }
    q << E.new(from: -1, to: init, cost: 0)

    seen = Array.new(n, false)
    fst = Array.new(n, INF)
    snd = Array.new(n, INF)
  
    while q.size > 0
      e = q.pop
      pv = e.from
      v = e.to
      cost = e.cost

      case
      when fst[v] == INF then fst[v] = cost
      when snd[v] == INF then snd[v] = cost
      else next
      end
      
      g[v].each do |ne|
        nv = ne.to
        ncost = ne.cost
        next if snd[nv] != INF
        q << E.new(from: v, to: nv, cost: cost + ncost)
      end
    end
    return snd
  end
end

snd = Graph(Edge).read.dijkstra(0)
pp snd
