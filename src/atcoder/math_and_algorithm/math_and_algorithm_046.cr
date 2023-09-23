require "crystal/grid"

h, w = gets.to_s.split.map(&.to_i64)
root = Tuple(Int32, Int32).from gets.to_s.split.map(&.to_i.pred)
goal = Tuple(Int32, Int32).from gets.to_s.split.map(&.to_i.pred)
g = Grid.new(Array.new(h) { gets.to_s })

q = Deque.new([root])
depth = Hash(typeof(root), Int32).new(0)
depth[root] = 0

while q.size > 0
  v = q.shift
  quit depth[goal] if v == goal

  g.each_with_index(v) do |c, nv|
    next if c == '#'
    next if depth.has_key?(nv)
    depth[nv] = depth[v] + 1
    q << nv
  end
end
