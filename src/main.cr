require "crystal/union_find_tree"

n, m = gets.to_s.split.map(&.to_i)
g = Array.new(n){ [] of Int32 }

edges = [] of Tuple(Int32,Int32)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.- 1)
  g[v] << nv
  g[nv] << v

  edges << { v, nv }
end

up = Array.new(n, -1)
up[0] = 0
q = Deque.new([0])
while q.size > 0
  v = q.shift
  g[v].each do |nv|
    next if up[nv] != -1
    up[nv] = up[v] + 1
  end
end

min = up[-1]

dn = Array.new(n, -1)
dn[n-1] = 0
q = Deque.new([n-1])
while q.size > 0
  v = q.shift
  g[v].each do |nv|
    next if dn[nv] != -1
    dn[nv] = dn[v] + 1
  end
end

min_path = [] of Tuple(Int32,Int32,Int32)
i = 0
costs = edges.map do |v, nv|
  v, nv = nv , v if up[v] > up[nv]
  cnt = up[v] + dn[nv] + 1
  if cnt == min
    min_path << { v, nv, i }
  end
  i += 1
  cnt
end

bridge = [] of Int32
min_path.each_with_index do |(v, nv, i)|
  uf = UnionFindTree.new(n)
  min_path.each_with_index do |(vv, nvv, j)|
    next if i == j
    uf.unite(vv,nvv)
  end
  if uf.same?(v, nv)
  else
    bridge << i
  end
end

if bridge.empty?
  m.times do
    puts min
  end
else
  bv, bnv = edges[bridge.first]
  dp = Array.new(n, -1)
  dp[0] = 0
  q = Deque.new([0])
  while q.size > 0
    v = q.shift
    g[v].each do |nv|
      next if v == bv && nv == bnv
      next if dp[nv] != -1
      dp[nv] = dp[v] + 1
      q << nv
    end
  end

  m.times do |i|
    if i.in?(bridge)
      puts dp[-1]
    else
      puts min
    end
  end
end
