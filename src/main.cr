class PriorityQueue(T)
  getter heap : Array(T)

  def initialize
    @heap = [] of T
  end

  def initialize(heap : Enumerable(T))
    @heap = heap.to_a.sort
  end

  # log( log n )
  def push(x : T)
    i = @heap.size
    return @heap = [x] if i == 0

    @heap << @heap[0]
    while i > 0
      par = ( i - 1 ) // 2
      break if @heap[par] <= x

      @heap[i] = @heap[par]
      i = par
    end
    @heap[i] = x
    self
  end

  # log( log n )
  # return error if pop when @size == 0
  def pop : T
    ret = @heap[0]
    sz = @heap.size - 1
    x = @heap[sz]

    i = 0
    while (child1 = i * 2 + 1) < sz
      child2 = i * 2 + 2
      child1 = child2 if child2 < sz && @heap[child2] < @heap[child1]
      break if @heap[child1] >= x

      @heap[i] = @heap[child1]
      i = child1
    end

    @heap[i] = x
    @heap.delete_at(-1)
    ret
  end

  def pop? : T?
    @heap.empty? ? nil : pop
  end

  def top : T
    @heap[0]
  end

  def any?
    !@heap.empty?
  end

  delegate :empty?, to: @heap
  delegate :size, to: @heap
end

class Array
  def to_pq
    PriorityQueue.new(self)
  end
end

# Min Cost Flow Grapsh
class Graph
  class Edge
    getter to : Int32
    property rev : Int32
    property cap : Int64
    property cost : Int64
    def initialize(@to, @rev, @cap, @cost)
    end
    def inspect(io)
      io << "{to: #{@to}, rev: #{@rev}, cap: #{@cap}, cost: #{@cost}}"
    end
  end

  getter n : Int32
  getter g : Array(Array(Edge))
  getter pos : Array(Tuple(Int32, Int32))
  def initialize(@n)
    @n    = n
    @pos  = [] of Tuple(Int32, Int32)
    @g = Array(Array(Edge)).new(@n){ [] of Edge }
    @pv   = Array(Int32).new(n, 0)
    @pe   = Array(Int32).new(n, 0)
    @dual = Array(Int64).new(n, 0)
  end

  def add(from, to, cap, cost) : Int32
    cost = cost.to_i64
    edge_number = @pos.size

    @pos << {from, @g[from].size}

    from_id = @g[from].size
    to_id   = @g[to].size
    to_id += 1 if from == to
    @g[from] << Edge.new(to, to_id, cap.to_i64, cost)
    @g[to]   << Edge.new(from, from_id, 0i64, -cost)

    edge_number
  end

  def get_edge(i)
    _e = @g[@pos[i][0]][@pos[i][1]]
    _re = @g[_e.to][_e.rev]
    [@pos[i][0], _e.to, _e.cap + _re.cap, _re.cap, _e.cost]
  end

  def edges
    @pos.map do |(from, id)|
      _e  = @g[from][id]
      _re = @g[_e.to][_e.rev]
      [from, _e.to, _e.cap + _re.cap, _re.cap, _e.cost]
    end
  end

  def flow(s, t, flow_limit = Int64::MAX)
    slope(s, t, flow_limit).last
  end

  def dual_ref(s, t)
    dist = Array.new(@n, Int64::MAX)
    @pv.fill(-1)
    @pe.fill(-1)
    vis = Array(Bool).new(@n, false)

    que = PriorityQueue(Tuple(Int64, Int32)).new
    dist[s] = 0
    que.push({0i64, s})

    while dv = que.pop?
      d, v = dv
      next if vis[v]

      vis[v] = true
      break if v == t

      @g[v].size.times do |i|
        e = @g[v][i]
        next if vis[e.to] || e.cap == 0

        cost = e.cost - @dual[e.to] + @dual[v]
        next unless dist[e.to] - dist[v] > cost

        dist[e.to] = dist[v] + cost
        @pv[e.to] = v
        @pe[e.to] = i
        que.push({dist[e.to], e.to})
      end
    end

    return false unless vis[t]

    @n.times do |i|
      next unless vis[i]

      @dual[i] -= dist[t] - dist[i]
    end

    true
  end

  def slope(s, t, flow_limit = Int64::MAX)
    flow = 0
    cost = 0
    prev_cost = -1
    result = [[flow, cost]]

    count = 0
    while flow < flow_limit
      pp! (count+=1)

      break unless dual_ref(s, t)

      c = flow_limit - flow
      v = t
      while v != s
        c = @g[@pv[v]][@pe[v]].cap if c > @g[@pv[v]][@pe[v]].cap
        v = @pv[v]
      end

      v = t
      while v != s
        e = @g[@pv[v]][@pe[v]]
        e.cap -= c
        @g[v][e.rev].cap += c
        v = @pv[v]
      end

      d = -@dual[s]
      flow += c
      cost += c * d
      result.pop if prev_cost == d
      result << [flow, cost]
      prev_cost = d
    end

    result
  end
end

def test_dayo
  # r, g, b = gets.to_s.split.map{ |e| e.to_i }
  r, g, b = [2i64, 3i64, 4i64]
  v = 1006
  graph = MinCostFlow.new(v)
  graph.add(0, 3, b.to_i64, 0i64)
end

# test_dayo

def abc004
  r, g, b = gets.to_s.split.map{ |e| e.to_i }
  # r, g, b = [2i64, 3i64, 4i64]
  v = 1006
  graph = MinCostFlow.new(v)
  graph.add(0, 1, r, 0i64);
  graph.add(0, 2, g, 0i64);
  graph.add(0, 3, b, 0i64);

  (-500 .. 500).each do |i|
    graph.add(1, i + 504, 1, (i + 100).abs.to_i64) # red(-100)
    graph.add(2, i + 504, 1, i.abs.to_i64)         # green(0)
    graph.add(3, i + 504, 1, (i - 100).abs.to_i64) # blue(100)
    graph.add(i + 504, 1005, 1, 0i64)
  end

  puts graph.flow(0, 1005, r + g + b)[-1]
end

red, green, blue = gets.to_s.split.map(&.to_i64)
n = 1001

g = Graph.new(n)

source = 0
sink = 1000

g.add source, 400, red, 0
g.add source, 500, green, 0
g.add source, 600, blue, 0

(1...1000).each do |v|
  g.add v, sink, 1, 0
end

[400, 500, 600].each do |v|
  (1...1000).each do |nv|
    cost = (v - nv).abs
    # next if cost > 350
    g.add v, nv, 1, cost
  end
end

ans = g.flow(source, sink, red + green + blue)[-1]
pp ans
