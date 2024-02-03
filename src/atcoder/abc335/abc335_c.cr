require "crystal/complex"
n, q = gets.to_s.split.map(&.to_i64)
dragon = Deque.new ((1..n).map do |i|
  i.x + 0.y
end)

q.times do
  cmd, x = gets.to_s.split
  case cmd
  when "1"
    case x
    when "R"
      dragon.unshift(dragon[0] + 1)
    when "L"
      dragon.unshift(dragon[0] - 1)
    when "U"
      dragon.unshift(dragon[0] + 1.y)
    when "D"
      dragon.unshift(dragon[0] - 1.y)
    end
  when "2"
    pos = dragon[x.to_i.pred]
    puts "#{pos.x} #{pos.y}"
  end
end