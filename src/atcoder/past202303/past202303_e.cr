h,w = gets.to_s.split.map(&.to_i64)
s = Array.new(h){gets.to_s.chars.count('#')}
t = Array.new(h){gets.to_s.chars.count('#')}
puts s == t ? :Yes : :No