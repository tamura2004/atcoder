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
    seen
  end
end

class Problem
  getter n : Int32
  getter m : Int32
  getter s : Array(Array(Char))
  getter g : MaxFlow(Int32)
  
  def initialize
    @n, @m = gets.to_s.split.map { |v| v.to_i }
    @s = Array.new(n) { gets.to_s.chomp.chars }
    @g = MaxFlow(Int32).new(n*m + 2)
  end
  
  def add_edge_from_origin
    n.times do |y|
      m.times do |x|
        next if s[y][x] == '#'
        if (x+y).even?
          i = y * m + x + 1
          g.add_edge(0, i, 1)
        end
      end
    end
  end
  
  def add_edge_to_sink
    n.times do |y|
      m.times do |x|
        next if s[y][x] == '#'
        if (x+y).odd?
          i = y * m + x + 1
          g.add_edge(i, n*m + 1, 1)
        end
      end
    end
  end

  def add_edge_brtween_board
    n.times do |sy|
      m.times do |sx|
        next if s[sy][sx] == '#'
        [[sy,sx+1],[sy+1,sx]].each do |(ty,tx)|
          next if ty == n || tx == m
          next if s[ty][tx] == '#'
          from = sy * m + sx + 1
          to = ty * m + tx + 1
          if (sx+sy).even?
            g.add_edge(from, to, 1)
          else
            g.add_edge(to, from, 1)
          end
        end
      end
    end
  end
  
  def solve
    add_edge_from_origin
    add_edge_to_sink
    add_edge_brtween_board
  end

  def show(ans)
    num = g.max_flow(0, n*m + 1)
    edges = g.g.flatten.select do |e|
      e.cap.zero? &&
      e.forward &&
      e.from != 0 &&
      e.to !=  n * m + 1
    end

    edges.each do |e|
      fy = (e.from - 1) // m
      fx = (e.from - 1) % m
      ty = (e.to - 1) // m
      tx = (e.to - 1) % m
      if fy == ty # horizontal
        fx, tx = tx, fx if fx > tx
        s[fy][fx] = '>'
        s[ty][tx] = '<'
      else # virtical
        fy, ty = ty, fy if fy > ty
        s[fy][fx] = 'v'
        s[ty][tx] = '^'
      end
    end
  
    puts num
    s.each do |row|
      puts row.join
    end
  end

  def instance_eval
    with self yield
  end
end

Problem.new.instance_eval do
  show(solve)
end