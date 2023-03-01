n = gets.to_s.to_i64
s = gets.to_s

x = 0
y = 0
seen = [{x,y}].to_set

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
  if seen.includes?({x,y})
    quit "Yes"
  end
  seen << {x,y}
end
puts "No"
