class Tree(T)
  getter n : Int64
  getter g : Array(Array(T))
  getter parent : Array(T)
  getter dist : Array(T)
  forward_missing_to g

  def initialize(@n)
    @g = Array.new(n){ [] of T }
    @parent, @dist = bfs(0)
  end
  
  def initialize(@n,@g)
    @parent, @dist = bfs(0)
  end
  
  def bfs(root)
    parent = Array.new(n, -1)
    dist = Array.new(n, -1)
    que = Deque.new
    que << root
    dist[root] = 0
    while que.size > 0
      v = que.shift
      d = dist[v]
      g[v].each do |nv|
        next if dist[nv] != -1
        dist[nv] = d + 1
        parent[nv] = v
        que << nv
      end
    end
    return ({parent, dist})
  end
end

n = 4
a = [[0,1],[0,2],[1,3],[1,4]]
g = Graph(Iny32).new(n,a)
pp! g.bfs