def solve(x,y)
  i = 0
  i += 1 if y > 0
  i += 2 if x >= 0
  i += 4 if y > x
  i += 8 if y > -x
  
  case i
  when 4,15
    y - x
  when 2,5
    1 - y - x
  when 10,13
    1 + x + y
  when 0,11
    x - y + 2
  end
end

x,y = gets.split.map &:to_i
puts solve(x,y)

