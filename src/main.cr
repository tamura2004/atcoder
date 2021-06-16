class Graph
  getter n : Int32
  getter g : Array(Array(Int32))

  def initialize(@n)
    @g = Array.new(n){ [] of Int32 }
  end

  def self.read
    n,m = gets.to_s.split.map(&.to_i)
    g = new(n)
    m.times do
      a,b = gets.to_s.split.map(&.to_i)
      g.add a, b
    end
    g
  end

  def add(v, nv, origin = 1, both = false)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v if both
  end

  def bfs(v)
    q = Deque.new([v])
    seen = Array.new(n, false)
    seen[v] = true
    cnt = 1_i64
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        cnt += 1
        q << nv
      end
    end
    cnt
  end

  def solve
    ans = 0_i64
    n.times do |v|
      ans += bfs(v)
    end
    pp ans
  end
end

Graph.read.solve
