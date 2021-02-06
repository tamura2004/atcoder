class Graph
  getter n : Int32
  getter g : Array(Array(Int32))

  def initialize(@n)
    @g = Array.new(n) { [] of Int32 }
  end

  def solve
    seen = Array.new(n, -1)
    seen[0] = 0
    q = Deque.new([0])
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if seen[nv] != -1
        seen[nv] = seen[v] + 1
        q << nv
      end
    end
    return seen
  end

  delegate "[]", to: @g
end

n = gets.to_s.to_i
g = Graph.new(n)
edges = [] of Tuple(Int32,Int32)
(n-1).times do
  a,b = gets.to_s.split.map { |v| v.to_i - 1 }
  g[a] << b
  g[b] << a
  edges << {a,b}
end
depth = g.solve

dp = Array.new(n, 0_i64)
q = gets.to_s.to_i
q.times do
  t,i,x = gets.to_s.split.map { |v| v.to_i64 }
  i = i.to_i - 1
  a,b = edges[i]

  case
  when t == 1
    if depth[a] < depth[b]
      dp[0] += x
      dp[b] -= x
    else
      dp[a] += x
    end
  when t == 2
    if depth[a] > depth[b]
      dp[0] += x
      dp[a] -= x
    else
      dp[b] += x
    end
  end
end

q = Deque.new([{0,-1}])
while q.size > 0
  v,pv = q.shift
  g[v].each do |nv|
    next if pv == nv
    dp[nv] += dp[v]
    q << {nv,v}
  end
end

puts dp.join("\n")

