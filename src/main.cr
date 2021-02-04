class Graph
  getter n : Int32
  getter g : Array(Array(Int32))

  def initialize(@n,@g)
  end

  def solve(from, to)
    seen = Array.new(n, false)
    seen[from] = true
    prev = Array.new(n, -1)
    q = Deque.new([from])
    while q.size > 0
      v = q.shift

      if v == to
        ans = [] of Int32
        while v != -1
          ans << v
          v = prev[v]
        end
        return ans
      end

      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        prev[nv] = v
        q << nv
      end
    end
    return nil
  end
end

n,m = gets.to_s.split.map { |v| v.to_i }
g = Array.new(n){ [] of Int32 }
edges = [] of Tuple(Int32,Int32)
m.times do
  from,to = gets.to_s.split.map { |v| v.to_i - 1 }
  g[from] << to
  edges << {from,to}
end

graph = Graph.new(n,g)

ans = nil : Array(Int32)?

edges.each do |from,to|
  if cnt = graph.solve(to,from)
    ans = cnt if ans.nil? || ans.size > cnt.size
  end
end

if ans
  puts ans.size
  puts ans.map(&.+ 1).join("\n")
else
  puts -1
end
