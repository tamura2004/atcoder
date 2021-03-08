n = 3
a = [
  "###",
  "..#",
  "..#"
]

g = Graph.new(8)
s = n * 2
t = s + 1
3.times do |i|
  g.add_edge(s,i,1)
  g.add_edge(i+n,t,1)
  3.times do |j|
    if a[i][j] == '#'
      g.add_edge(i, j+n, 1)
    end
  end
end

pp g.flow(s,t)

alias To = Int32
alias Rev = Int32
alias Cap = Int64
alias Edge = Tuple(To, Rev, Cap)

class Graph
  getter n : Int32
  getter g : Array(Array(Edge))
  getter depth : Array(Int32)
  getter visit : Array(Int32)

  def initialize(@n)
    @g = Array.new(n) { [] of Edge }
    @depth = Array.new(n, -1)
    @visit = Array.new(n, 0)
  end

  def add_edge(from, to, cap)
    cap = Cap.new(cap)
    rev_from = g[from].size
    rev_to = g[to].size
    g[from] << Edge.new(to, rev_to, cap)
    g[to] << Edge.new(from, rev_from, Cap.zero)
  end

  def flow(start, target) : Cap
    flow = 0_i64
    loop do
      bfs(start)
      return flow if depth[target] < 0
      visit.fill(0)
      while (flowed = dfs(start, target, Cap::MAX)) > 0
        flow += flowed
      end
    end
  end

  def bfs(start)
    depth.fill(-1)
    depth[start] = 0
    q = Deque.new([start])
    while q.size > 0
      v = q.shift
      g[v].each do |nv, rev, cap|
        next if depth[nv] != -1
        next if cap <= 0
        depth[nv] = depth[v] + 1
        q << nv
      end
    end
  end

  def dfs(v, target, flow) : Cap
    return flow if v == target
    edges = g[v]
    while visit[v] < edges.size
      i = visit[v]
      nv, rev, cap = edges[i]
      if cap > 0 && depth[v] < depth[nv]
        flowed = dfs(nv, target, Math.min(flow, cap))
        if flowed > 0
          edges[i] = add_cap(edges[i], -flowed)
          g[nv][rev] = add_cap(g[nv][rev], flowed)
          return flowed
        end
      end
      visit[v] += 1
    end
    0_i64
  end

  @[AlwaysInline]
  def add_cap(e : Edge, cost : Cap)
    nv, rev, cap = e
    Edge.new(nv, rev, cap + cost)
  end
end
