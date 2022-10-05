require "crystal/graph/grid"

h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s }
g = Grid.new(h, w, a)

sz = g.index('s')
gz = g.index('g')

q = Deque.new([{sz, 0}])
seen = [sz].to_set

while q.size > 0
  z, cost = q.shift
  next if cost >= 3

  g.each(z, wall: false) do |nz|
    next if nz.in?(seen)
    seen << nz

    case g[nz]
    when '.'
      q.unshift({nz, cost})
    when '#'
      q << {nz, cost + 1}
    when 'g'
      quit "YES"
    end
  end
end

puts "NO"
