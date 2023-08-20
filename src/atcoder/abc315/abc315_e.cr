require "crystal/graph"

n = gets.to_s.to_i
g = n.to_g

n.times do |v|
  c, *p = gets.to_s.split.map(&.to_i.pred)
  p.each do |nv|
    g.add v, nv, origin: 0, both: false
  end
end

ans = [] of Int32
seen = Array.new(n, false)
seen[0] = true

dfs = uninitialized (Int32, Int32) -> Nil
dfs = ->(v : Int32, pv : Int32) do
  g.each(v) do |nv|
    next if nv == pv
    next if seen[nv]
    seen[nv] = true
    dfs.call(nv, v)
  end
  ans << v
end
dfs.call(0, -1)

puts ans[0...-1].map(&.succ).join(" ")
