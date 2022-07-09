n = gets.to_s.to_i64
a = Array.new(n) do
  x, y = gets.to_s.split.map(&.to_i64)
  x == y
end

ans = a.chunk(&.itself).select(&.first).map(&.last.size).to_a
puts ans.empty? || ans.max < 3 ? "No" : "Yes"