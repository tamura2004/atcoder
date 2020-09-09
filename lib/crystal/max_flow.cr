class MaxFlow(T)
  class Edge(T)
    property from : Int32
    property to : Int32
    property cap : T
    property rev : Int32
    getter forward : Bool

    def initialize(@from, @to, @cap, @rev, @forward); end
  end

  getter n : Int32
  getter g : Array(Array(Edge(T)))
  getter seen : Array(Bool)

  def initialize(@n)
    @g = Array.new(n) { [] of Edge(T) }
    @seen = Array.new(n, false)
  end

  def add_edge(from, to, cap)
    raise "MaxFlow#add_edge: bad from #{from}" unless (0...n).includes? from
    raise "MaxFlow#add_edge: bad to #{to}" unless (0...n).includes? to
    g[from] << Edge(T).new(from, to, cap, g[to].size, true)
    g[to] << Edge(T).new(to, from, T.zero, g[from].size - 1, false)
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
end
