n, q = gets.to_s.split.map(&.to_i64)
s = Set(Tuple(Int64, Int64)).new

q.times do
  t, a, b = gets.to_s.split.map(&.to_i64)
  case t
  when 1
    s << {a, b}
  when 2
    s.delete({a, b})
  when 3
    puts s.includes?({a, b}) && s.includes?({b, a}) ? :Yes : :No
  end
end
