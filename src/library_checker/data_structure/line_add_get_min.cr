require "crystal/cht"

n, q = gets.to_s.split.map(&.to_i64)
cht = CHT.new

n.times do
  a, b = gets.to_s.split.map(&.to_i64)
  cht << Line.new(a, b)
end

q.times do
  cmd, a, b = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 0
    cht << Line.new(a, b)
  when 1
    puts cht.min(a)
  end
end

