# 訪問順を記録、後退辺があったら訪問順以降がcycle

n = gets.to_s.to_i64
nex = gets.to_s.split.map(&.to_i.pred)
ord = Array.new(n, -1)
visit = [] of Int32

v = 0
root = -1
loop do
  ord[v] = visit.size
  visit << v

  nv = nex[v]
  if ord[nv] != -1
    root = ord[nv]
    break
  else
    v = nv
  end
end

# pp! root
# pp! visit

cycle = visit[root..]
puts cycle.size
puts cycle.map(&.succ).join(" ")
