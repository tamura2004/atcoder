n = gets.to_s.to_i
q = []

n.times do
  t, x = gets.to_s.split.map { |v| v.to_i }
  case t
  when 1
    q.unshift x
  when 2
    q << x
  when 3
    puts q[x - 1]
  end
end
