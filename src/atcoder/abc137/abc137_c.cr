n = gets.to_s.to_i64
s = Array.new(n) do
  gets.to_s.chars.sort.join
end

ans = s.tally.values.sum do |num|
  num.to_i64 * (num - 1) // 2
end

pp ans