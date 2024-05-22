require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i)
g = n.to_g

m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, origin: 0, both: false
end

enum Vertex
  None
  Enter
  Leave
end

seen = Array.new(n, Vertex::None)
history = Deque(Tuple(Int32,Int32)).new

dfs = uninitialized Proc(Int32, Int32, Int32)
dfs = -> (v : Int32, i : Int32) do
  seen[v] = Vertex::Enter
  history << { v, i }
  g.each_with_edge_index(v) do |nv, j|
    next if seen[nv].leave?
    if seen[nv].enter?
      history << { nv, j }
      return nv
    end
    pos = dfs.call(nv, j)
    return pos if pos != -1
  end
  seen[v] = Vertex::Leave
  history.pop
  -1
end

pos = -1
n.times do |v|
  next unless seen[v].none?
  pos = dfs.call(v, -1)
  break if pos != -1
end

if pos == -1
  pp -1
else
  loop do
    v, i = history.shift
    break if v == pos
  end
  ans = history.map(&.last)
  puts ans.size
  puts ans.join("\n")
end
