n = gets.to_s.to_i64
cnt = Array.new(n) do
  n - gets.to_s.count('o')
end

puts cnt.zip(1..).sort.map(&.[1]).join(" ")
