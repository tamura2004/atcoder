q = gets.to_s.to_i
a = Deque.new([] of Int32)

q.times do
  cmd, x = gets.to_s.split.map(&.to_i)
  case cmd
  when 1
    a.unshift x
  when 2
    puts a[x.pred]
  end
end