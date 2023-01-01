require "crystal/matrix"

z = C.read
g = Matrix(Int32).from_rows(z) do
  gets.to_s.chars.map(&.==('#').to_unsafe)
end

cnt = (0...2).map do
  g = g.transpose
  g.rows.map(&.sum)
end

z.y.times do |y|
  next if cnt[1][y].zero?
  z.x.times do |x|
    next if cnt[0][x].zero?
    print g[y.y+x.x].zero? ? '.' : '#'
  end
  puts
end
