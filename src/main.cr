require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end
s = gets.to_s.chars.map(&.to_i)
ans = [] of Int32
seen = Array.new(n, false)
seen[0] = true

# g.debug

dfs = uninitialized Proc(Int32, Int32, Nil)
dfs = -> (v : Int32, pv : Int32) do
  ans << v + 1
  s[v] ^= 1
  g[v].each do |nv|
    next if seen[nv]
    seen[nv] = true
    dfs.call(nv, v)
    ans << v + 1
    s[v] ^= 1
  end

  if s[v] == 1 && v != 0
    ans << pv + 1
    ans << v + 1
    s[pv] ^= 1
    s[v] ^= 1
  end
end
dfs.call(0, -1)
ans.pop if s[0] == 1
puts ans.size
puts ans.join(" ")
# pp ans.tally