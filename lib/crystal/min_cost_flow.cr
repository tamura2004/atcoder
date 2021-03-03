class MinCostFlow
  class Edge
    property :to, :cap, :cost, :rev

    def initialize(@to : Int32, @cap : Int32, @cost : Int64, @rev : Int32)
    end
  end

  getter :g
  @g : Array(Array(Edge))

  def initialize(size : Int32)
    @g = Array.new(size) { Array(Edge).new }
  end

  def add_edge(s : Int32, t : Int32, cost : Int64, cap : Int32)
    @g[s] << Edge.new(t, cap, cost, @g[t].size)
    @g[t] << Edge.new(s, 0, -cost, @g[s].size - 1)
  end

  def calc(flow : Int32, s : Int32, t : Int32)
    n = @g.size
    result = 0i64
    h = Array.new(n, 0i64)
    prev = Array(Edge?).new(n, nil)
    que = PriorityQueue(Int64).new(n)
    dist = Array.new(n, 0i64)
    while flow > 0
      dist.fill(Int64::MAX // 2)
      dist[s] = 0
      que.add(s.to_i64)
      while que.size > 0
        cur = que.pop
        cv = cur >> 10
        cp = (cur & 0x3FF).to_i
        next if -cv > dist[cp]
        @g[cp].each do |edge|
          next if edge.cap == 0
          n_cost = dist[cp] + edge.cost + h[cp] - h[edge.to]
          if n_cost < dist[edge.to]
            dist[edge.to] = n_cost
            que.add(((-n_cost) << 10) | edge.to)
            prev[edge.to] = edge
          end
        end
      end
      n.times do |i|
        h[i] += dist[i]
      end
      break if h[t] >= 0
      f = flow
      pos = t
      while pos != s
        pe = prev[pos].not_nil!
        f = {f, pe.cap}.min
        pos = @g[pos][pe.rev].to
      end
      pos = t
      while pos != s
        pe = prev[pos].not_nil!
        pe.cap -= f
        @g[pos][pe.rev].cap += f
        pos = @g[pos][pe.rev].to
      end
      result += h[t] * f
      flow -= f
    end
    return result
  end
end

class PriorityQueue(T)
  def initialize(capacity : Int32)
    @elem = Array(T).new(capacity)
  end

  def initialize(list : Enumerable(T))
    @elem = list.to_a
    1.upto(size - 1) { |i| fixup(i) }
  end

  def size
    @elem.size
  end

  def add(v)
    @elem << v
    fixup(size - 1)
  end

  def top
    @elem[0]
  end

  def pop
    ret = @elem[0]
    last = @elem.pop
    if size > 0
      @elem[0] = last
      fixdown(0)
    end
    ret
  end

  def clear
    @elem.clear
  end

  def decrease_top(new_value : T)
    @elem[0] = new_value
    fixdown(0)
  end

  def to_s(io : IO)
    io << @elem
  end

  private def fixup(index : Int32)
    while index > 0
      parent = (index - 1) // 2
      break if @elem[parent] >= @elem[index]
      @elem[parent], @elem[index] = @elem[index], @elem[parent]
      index = parent
    end
  end

  private def fixdown(index : Int32)
    while true
      left = index * 2 + 1
      break if left >= size
      right = index * 2 + 2
      child = right >= size || @elem[left] > @elem[right] ? left : right
      if @elem[child] > @elem[index]
        @elem[child], @elem[index] = @elem[index], @elem[child]
        index = child
      else
        break
      end
    end
  end
end