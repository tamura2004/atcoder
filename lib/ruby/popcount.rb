N = 8
M = 1 << N

POPCOUNT = M.times.map do |i|
  N.times.select { |j| i >> j & 1 == 1 }.size
end

CANDIDATE = M.times.map do |i|
  N.times.select { |j| i >> j & 1 == 0 }
end

class Queen
  attr_accessor :ans, :seen

  def initialize(ans = nil, seen = nil)
    @ans = ans || [0] * N
    @seen = seen || [0] * N
  end

  def dup
    Queen.new(@ans.dup, @seen.dup)
  end

  def candidate
    seen.each_with_index do |row, y|
      CANDIDATE[row].each do |x|
        yield dup.set(y, x)
      end
    end
  end

  def goal?
    ans.map { |v| POPCOUNT[v] }.inject(:+) == N
  end

  def set(y, x)
    set_queen(y, x)
    set_column(x)
    set_row(y)
    set_diag(y, x, 1, 1)
    set_diag(y, x, 1, -1)
    set_diag(y, x, -1, 1)
    set_diag(y, x, -1, -1)
    self
  end

  def set_queen(y, x)
    ans[y] |= 1 << x
  end

  def set_column(x)
    mask = 1 << x
    seen.map! { |v| v | mask }
  end

  def set_row(y)
    seen[y] = M - 1
  end

  def set_diag(y, x, dx, dy)
    inside = ->y, x, h, w { 0 <= y && y < h && 0 <= x && x < w }
    while inside[y, x, N, N]
      seen[y] |= 1 << x
      x += dx
      y += dy
    end
  end

  def to_s
    ans.map do |v|
      sprintf("%0*b", N, v).gsub(/0/, ".").gsub(/1/, "Q").reverse
    end.join("\n")
  end

  def inspect
    seen.map do |v|
      sprintf("%0*b", N, v).gsub(/0/, ".").gsub(/1/, "x").reverse
    end.join("\n") + ("-" * N) + to_s
  end
end

v = Queen.new
n = gets.to_i
n.times do
  y, x = gets.split.map &:to_i
  v.set(y, x)
end

que = [v]
while !que.empty?
  now = que.shift
  if now.goal?
    puts now
    exit
  else
    now.candidate do |nq|
      que << nq
    end
  end
end
