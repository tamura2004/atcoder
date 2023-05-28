n, m, h, k = gets.to_s.split.map(&.to_i64)
s = gets.to_s
item = Set(Tuple(Int64, Int64)).new
m.times do
  x, y = gets.to_s.split.map(&.to_i64)
  item << ({x, y})
end

x = y = 0_i64
n.times do |i|
  case s[i]
  when 'R'
    x += 1
  when 'L'
    x -= 1
  when 'U'
    y += 1
  when 'D'
    y -= 1
  end
  h -= 1
  if h < 0
    quit "No"
  end

  if item.includes?({x, y}) && h < k
    h = k
    item.delete({x, y})
  end
end
puts "Yes"
