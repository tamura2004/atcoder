class Grid
  attr_accessor :h
  attr_accessor :w
  attr_accessor :s
  attr_accessor :g

  def initialize(h, w, s)
    @h = h
    @w = w
    @s = s
    @g = Array.new(h) { Array.new(w, 0) }
    h.times do |y|
      w.times do |x|
        g[y][x] = s[y * w + x]
      end
    end
  end

  def [](y, x)
    if 0 <= x && x < w && 0 <= y && y < h
      g[y][x]
    else
      0
    end
  end

  def white?(y, x)
    self[y, x] == 0
  end

  def black?(y, x)
    !white?(y, x)
  end

  def valid?
    h.times.all? do |y|
      w.times.all? do |x|
        white?(y - 1, x) && white?(y - 1, x - 1) || black?(y, x)
      end
    end
  end

  def c(i)
    s[i] == 1 ? "●" : "○"
  end

  def to_s
    ans = g.map do |row|
      row.map do |cell|
        cell == 1 ? "●" : "○"
      end.join(" ")
    end.join("\n")

    "===\n#{s}\n" + ans
  end
end

cnt = 0
(1 << 12).times do |s|
  g = Grid.new(3, 3, s)
  next unless g.valid?
  puts g
  cnt += 1
end

pp "---"
pp cnt
