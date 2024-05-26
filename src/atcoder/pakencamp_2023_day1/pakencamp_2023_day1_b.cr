n = gets.to_s.to_i64
a, b = gets.to_s.split.map(&.to_i64).sort
c, d = gets.to_s.split.map(&.to_i64).sort

a,b,c,d = c,d,a,b unless a < c

if [a, b, c, d].uniq.size == 3
  puts 3
elsif b.in?(c..d)
  puts 4
else
  puts 3
end
