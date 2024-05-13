n = gets.to_s.to_i64
g = Array.new(n) do
  a, b = gets.to_s.split.map(&.to_i64)
  { a, b }
end

tot = g.map(&.[0]).sum

ans = g.max_of do |a, b|
  tot - a + b
end

pp ans