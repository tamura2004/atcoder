require "crystal/graph"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
g = n.to_g

(1..n).each do |v|
  g.add v, a[v.pred], both: false
end

indeg = Array.new(n, 0_i64)
n.times do |v|
  g.each(v) do |nv|
    indeg[nv] += 1
  end
end

q = Deque(Int32).new
n.times do |v|
  if indeg[v] == 0
    q << v
  end
end

ans = n
while q.size > 0
  v = q.shift
  ans -= 1
  g.each(v) do |nv|
    indeg[nv] -= 1
    if indeg[nv] == 0
      q << nv
    end
  end
end

pp ans