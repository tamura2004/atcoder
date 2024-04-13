s = gets.to_s.upcase.chars + ['X']
t = gets.to_s.chars

i = 0
3.times do |j|
  i = s.index(t[j], i)
  quit "No" if i.nil?
  i += 1
end
puts "Yes"