require "crystal/graph/grid"

h, w = gets.to_s.split.map(&.to_i)
sz = C.read.flip - C.new(1, 1)
gz = C.read.flip - C.new(1, 1)
a = Array.new(h) { gets.to_s }
g = Grid.new(h, w, a)

q = Deque.new([{sz, 0_i64}])
seen = [sz].to_set

while q.size > 0
  z, cost = q.shift
  quit cost if z == gz

  g.each(z) do |nz|
    next if nz.in?(seen)
    seen << nz
    q << {nz, cost + 1}
  end
end
