t = gets.to_s.to_i64
t.times do
  a,b,c = gets.to_s.split.map(&.to_i64).sort
  cnt = c * 2 - a - b
  if cnt % 6 == 0
    puts cnt // 6
  else
    puts -1
  end
end
