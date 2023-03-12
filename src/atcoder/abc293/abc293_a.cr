s = gets.to_s.chars
n = s.size
(n//2).times do |i|
  s.swap i*2,i*2+1
end
puts s.join