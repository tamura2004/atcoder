require "crystal/graph"
require "crystal/graph/parent"

n, x, y = gets.to_s.split.map(&.to_i)
x -= 1
y -= 1

g = Graph.new(n)
(n-1).times do
  g.read
end

pa = Array.new(n, -1)
dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  pa[v] = pv
  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v) 
  end
end
dfs.call(y, -1)

ans = [x]
while pa[x] != -1
  ans << pa[x]
  x = pa[x]
end

puts ans.map(&.succ).join(" ")