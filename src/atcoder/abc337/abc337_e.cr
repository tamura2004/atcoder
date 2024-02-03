n = gets.to_s.to_i64
m = Math.ilogb(Math.pw2ceil(7))
puts m
STDOUT.flush

m.times do |i|
  ju = [] of Int32 | Int64
  n.times do |j|
    if j.bit(i) == 1
      ju << j + 1
    end
  end
  ans = [ju.size] + ju
  puts ans.join(" ")
  STDOUT.flush
end  

s = gets.to_s.reverse.to_i(2)
puts s
STDOUT.flush

