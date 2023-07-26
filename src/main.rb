require "set"

UP = 1
DOWN = 2
LEFT = 3
RIGHT = 4
STOP = 5

h, w = gets.split.map(&:to_i)
g = Array.new(h) { gets.chomp }

q = [[1, 1, STOP]]
seen = Array.new(h) { Array.new(w) { Set.new } }
seen[1][1] << STOP

while q.size > 0
  y, x, dir = q.shift
  [[-1, 0, UP], [1, 0, DOWN], [0, 1, RIGHT], [0, -1, LEFT]].each do |dy, dx, ndir|
    next unless dir == STOP || dir == ndir
    ny = y + dy
    nx = x + dx
    if g[ny][nx] == "#"
      q << [y, x, STOP] if dir != STOP
      next
    end
    next if seen[ny][nx] === ndir
    seen[ny][nx] << ndir
    q << [ny, nx, ndir]
  end
end

pp h * w - seen.flatten.count(&:empty?)
