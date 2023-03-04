require "crystal/graph"
n, m = gets.to_s.split.map(&.to_i)
g = n.to_g
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end

ans = 0_i64
n.times do |i|
  seen = Array.new(n, false)
  seen[i] = true
  cnt = 0_i64

  dfs = uninitialized (Int32, Int32) -> Nil
  dfs = -> (v : Int32, pv : Int32) do
    cnt += 1
    g.each(v) do |nv|
      next if nv == pv
      next if seen[nv]
      seen[nv] = true
      dfs.call(nv, v)      
    end
  end
  dfs.call(i, -1)

  ans += cnt - 1 - g.g[i].size
end
pp ans