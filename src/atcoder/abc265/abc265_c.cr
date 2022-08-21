h, w = gets.to_s.split.map(&.to_i64)
g = Array.new(h){gets.to_s}
seen = Array.new(h){Array.new(w, false)}

y = x = 0

while true
  quit -1 if seen[y][x]
  seen[y][x] = true
  case g[y][x]
  when 'U'
    break if y == 0
    y -= 1
  when 'D'
    break if y == h - 1
    y += 1
  when 'L'
    break if x == 0
    x -= 1
  when 'R'
    break if x == w - 1
    x += 1
  end
end

puts "#{y+1} #{x+1}"