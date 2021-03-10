t = gets.to_s.to_i
t.times do
  n = gets.to_s.to_i
  s = Array.new(3){ gets.to_s }
  puts "0" * n + "1" * n + "0"
end
