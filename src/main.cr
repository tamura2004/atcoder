class Grid
  getter h : Int32
  getter w : Int32
  getter s : Array(String)

  def initialize(@h, @w, @s)
  end

  private def inside(y, x)
    0 <= y && y < h && 0 <= x && x < w
  end

  def each_adjust(y, x)
    [-1, 0, 1].product([-1, 0, 1]) do |dy, dx|
      next if dy.zero? && dx.zero?
      yield y + dy, x + dx if inside(y + dy, x + dx)
    end
  end

  def solve
    ans = Array.new(h) { Array.new(w) { "#" } }
    h.times do |y|
      w.times do |x|
        next if s[y][x] == '#'
        cnt = 0
        each_adjust(y, x) do |ny, nx|
          cnt += 1 if s[ny][nx] == '#'
        end
        ans[y][x] = cnt.to_s
      end
    end
    ans
  end
end

h, w = gets.to_s.split.map { |v| v.to_i }
s = Array.new(h) { gets.to_s.chomp }
ans = Grid.new(h, w, s).solve
ans.each do |line|
  puts line.join
end
