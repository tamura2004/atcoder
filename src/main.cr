require "crystal/grid_graph/graph"
include GridGraph

h, w = gets.to_s.split.map(&.to_i64)
g = Graph.new(h, w)
g.read

pp Problem.new(g).solve

class Problem
  getter g : Graph
  delegate h, w, "[]", to: g

  def initialize(@g)
  end

  def solve
    ans = 0_i64
    h.times do |y|
      w.times do |x|
        next if g.wall?(y,x)
        depth = bfs(y, x)
        maxi = depth.map(&.max).max
        chmax ans, maxi
      end
    end
    ans
  end

  def bfs(y, x)
    seen = make_array(false, h, w)
    depth = make_array(0i64, h, w)
    q = Deque.new([{y, x}])
    depth[y][x] = 0_i64
    seen[y][x] = true

    while q.size > 0
      y, x = q.shift
      g.each(y, x) do |ny, nx|
        next if seen[ny][nx]
        seen[ny][nx] = true
        depth[ny][nx] = depth[y][x] + 1
        q << {ny, nx}
      end
    end
    # puts "----"
    # puts depth.map(&.join(" ")).join("\n")
    depth
  end
end
