h, w = gets.to_s.split.map(&.to_i)
s = Array.new(h) { gets.to_s.chars }.transpose.map(&.join.hash).sort
t = Array.new(h) { gets.to_s.chars }.transpose.map(&.join.hash).sort
puts s == t ? "Yes" : "No"
