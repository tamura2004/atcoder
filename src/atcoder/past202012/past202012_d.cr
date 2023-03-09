n = gets.to_s.to_i64
s = Array.new(n){gets.to_s}

l = s.map(&.size).max
ss = s.map do |c|
  cnt = c.match(/^0+/).try(&.[0].size) || 0
  cc = "0" * (l - c.size) + c
  {cc, -cnt, c}
end.sort

puts ss.map(&.last).join("\n")