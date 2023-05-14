require "big"

t = gets.to_s.to_i64
t.times do
  a, b = gets.to_s.split.map(&.to_big_i)
  pp a + b
end
