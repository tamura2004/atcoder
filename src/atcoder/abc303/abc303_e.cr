require "crystal/graph"

n = gets.to_s.to_i
g = Graph.new(n)
deg = Array.new(n, 0)
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
  deg[v.pred] += 1
  deg[nv.pred] += 1
end

q = Deque(Int32).new
n.times do |v|
  if deg[v] == 1
    q << v
    break
  end
end

ans = [] of Int32
while q.size > 0
  v = q.shift
  vc = -1
  g.each(v) do |nv|
    next if deg[nv] <= 0
    vc = nv
    break
  end

  ans << deg[vc]
  deg[vc] = 0

  g.each(vc) do |nv|
    deg[nv] -= 1
    if deg[nv] == 1
      g.each(nv) do |nnv|
        next if nnv == vc
        deg[nnv] -= 1
        deg[nv] -= 1
        if deg[nnv] == 1
          q << nnv
        end
      end
    end
  end
end

puts ans.sort.join(" ")

