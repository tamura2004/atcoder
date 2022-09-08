require "crystal/graph"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end
ans = [] of Int32

dfs = uninitialized (Int32,Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  ans << v.succ

  vs = [] of Int32
  g.each(v) do |nv|
    vs << nv
  end
  vs.sort!

  vs.each do |nv|
    next if nv == pv
    dfs.call(nv, v)
    ans << v.succ
  end
end

dfs.call(0, -1)
puts ans.join(" ")
