class Grid
  attr_accessor :h, :w, :s, :seen

  def initialize(h, w, s)
    @h = h
    @w = w
    @s = s
    @seen = Array.new(h) { Array.new(w, -1) }
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def sea?(y, x)
    s[y][x] == "."
  end

  def each(y, x)
    [[1, 0], [0, 1], [-1, 0], [0, -1]].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if sea?(ny, nx)
      yield ny, nx
    end
  end

  def rec
    id = -1
    h.times do |sy|
      w.times do |sx|
        next if sea?(sy, sx)
        next if seen[sy][sx] != -1
        id += 1
        seen[sy][sx] = id
        q = [[sy, sx]]
        while q.size > 0
          y, x = q.shift
          each(y, x) do |ny, nx|
            next if seen[ny][nx] != -1
            seen[ny][nx] = id
            q << [ny, nx]
          end
        end
      end
    end
  end

  def solve
    rec
    area = Array.new(seen.flatten.max + 1, 0)
    surr = Array.new(seen.flatten.max + 1, 0)
    h.times do |y|
      w.times do |x|
        next if sea?(y, x)
        id = seen[y][x]
        area[id] += 1
        surr[id] += 4
        each(y, x) do |ny, nx|
          surr[id] -= 1
        end
      end
    end
    surr.zip(area).sort.reverse.each do |su, ar|
      puts "#{ar} #{su}"
    end
  end
end

h, w = gets.split.map(&:to_i)
s = Array.new(h) { gets.chomp }
g = Grid.new(h, w, s)
g.solve
