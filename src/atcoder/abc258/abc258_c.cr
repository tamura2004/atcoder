n, q = gets.to_s.split.map(&.to_i64)
s = gets.to_s

i = 0
q.times do
  cmd, x = gets.to_s.split.map(&.to_i64)
  case cmd
  when 1
    i = (i - x) % n
  when 2
    puts s[(i+x-1)%n]
  end
end
