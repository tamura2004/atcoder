n = gets.to_i
m = 0
while 2 ** m < n
    m += 1
end
puts m
STDOUT.flush

m.times do |i|
  ju = []
  n.times do |j|
    if j[i] == 1
      ju << j + 1
    end
  end
  ans = [ju.size] + ju
  puts ans.join(" ")
  STDOUT.flush
end  

s = gets.to_s.reverse.to_i(2)
puts s + 1
STDOUT.flush

