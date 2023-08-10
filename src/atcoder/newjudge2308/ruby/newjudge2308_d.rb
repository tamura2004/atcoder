n1, n2, m = gets.split.map(&:to_i)
g = Array.new(n1 + n2) { [] }
m.times do
  v, nv = gets.split.map(&:to_i)
  v -= 1
  nv -= 1
  g[v] << nv
  g[nv] << v
end

class Depth
  attr_reader :n, :g

  def initialize(g)
    @g = g
    @n = g.size
  end

  def solve(root)
    depth = Array.new(n, -1)
    depth[root] = 0
    q = [root]
    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if depth[nv] != -1
        depth[nv] = depth[v] + 1
        q << nv
      end
    end
    depth
  end
end

d1 = Depth.new(g).solve(0)
d2 = Depth.new(g).solve(n1 + n2 - 1)
ans = d1.max + d2.max + 1
pp ans
