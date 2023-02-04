n, m = gets.to_s.split.map(&.to_i64)
s = Array.new(n){gets.to_s.reverse[0,3]}
t = Array.new(m){gets.to_s.reverse}.to_set
ans = s.count(&.in?(t))
pp ans
