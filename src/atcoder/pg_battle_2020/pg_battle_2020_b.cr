n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sum
b = gets.to_s.split.map(&.to_i64).sum

case
when a == b
  puts :same
when a > b
  puts :A
when a < b
  puts :B
end
