h, w = gets.to_s.split.map(&.to_i)
g = Array.new(h){gets.to_s.chars}

seen = (1..2).map do
  g = g.transpose
  g.map(&.includes?('#'))
end

h.times do |y|
  w.times do |x|
    if g[y][x] == '.' && seen[0][x] && seen[1][y]
      quit "#{y.succ} #{x.succ}"
    end
  end
end


