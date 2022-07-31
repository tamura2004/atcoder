y = gets.to_s.to_i64

loop do
  if y % 4 == 2
    quit y
  end
  y += 1
end
