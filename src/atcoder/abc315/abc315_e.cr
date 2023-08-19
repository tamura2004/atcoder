require "crystal/graph"
require "crystal/graph/tsort"

n = gets.to_s.to_i
g = n.to_g

n.times do |v|
  c, *p = gets.to_s.split.map(&.to_i.pred)
  p.each do |nv|
    g.add v, nv, origin: 0, both: false
  end
end

# 読むべき本
seen = Array.new(n, false)
seen[0] = true
q = Deque.new([0])
while q.size > 0
  v = q.shift
  g.each(v) do |nv|
    next if seen[nv]
    seen[nv] = true
    q << nv
  end
end

# puts Tsort.new(g).solve.select { |v| seen[v] && v != 0 }.reverse.map(&.succ).join(" ")

# 読むべき本のみtsort
indeg = Array.new(n, 0)

seen[0] = false
n.times do |v|
  next unless seen[v]
  g.each(v) do |nv|
    next unless seen[nv]
    indeg[nv] += 1
  end
end

tsort = [] of Int32
q = Deque(Int32).new
n.times do |v|
  next unless seen[v]
  q << v if indeg[v] == 0
end

while q.size > 0
  v = q.shift
  tsort << v
  g.each(v) do |nv|
    next unless seen[nv]
    indeg[nv] -= 1
    if indeg[nv] == 0
      q << nv
    end
  end
end

puts tsort.reverse.map(&.succ).join(" ")
