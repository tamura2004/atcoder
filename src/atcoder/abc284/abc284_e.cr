require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  g.read
end

seen = Array.new(n, false)
ans = 0_i64

dfs = uninitialized (Int32) -> Nil
dfs = -> (v : Int32) do
  seen[v] = true
  ans += 1
  quit ans if 1_000_000 <= ans

  g.each(v) do |nv|
    next if seen[nv]
    dfs.call(nv)
  end
  
  seen[v] = false
end
dfs.call(0)
pp ans