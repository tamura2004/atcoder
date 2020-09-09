class MaxFlow(T)
  class Edge(T)
    property from : Int32
    property to : Int32
    property cap : T
    property rev : Int32

    def initialize(@from, @to, @cap, @rev); end
  end

  getter n : Int32
  getter g : Array(Array(Edge(T)))
  getter edges : Array(Edge(T))
  getter seen : Array(Bool)

  def initialize(@n)
    @g = Array.new(n) { [] of Edge(T) }
    @edges = [] of Edge(T)
    @seen = Array.new(n, false)
  end

  def add_edge(from, to, cap)
    forward = Edge(T).new(from, to, cap, g[to].size)
    reverse = Edge(T).new(to, from, T.zero, g[from].size - 1)
    g[from] << forward
    g[to] << reverse
    edges << forward
    edges << reverse
  end

  def dfs(v, t, f)
    return f if v == t
    seen[v] = true
    g[v].each do |e|
      next if seen[e.to] || e.cap <= 0
      d = dfs(e.to, t, [f, e.cap].min)
      next if d <= 0
      e.cap -= d
      g[e.to][e.rev].cap += d
      return d
    end
    return 0
  end

  def max_flow(s, t)
    flow = 0
    loop do
      seen.fill(false)
      f = dfs(s, t, T::MAX)
      return flow if f == 0
      flow += f
    end
  end

  def min_cut(s)
    seen = Array.new(n, false)
    que = [s]
    while que.size > 0
      v = que.shift
      seen[v] = true
      g[v].each do |e|
        next if e.cap.zero? || seen[e.to]
        seen[e.to] = true
        que << e.to
      end
    end
    # seen
    edges.select { |e|
      seen[e.from] & !seen[e.to]
    }.map { |e| {e.from, e.to} }
  end

  def instance_eval
    with self yield
  end
end
