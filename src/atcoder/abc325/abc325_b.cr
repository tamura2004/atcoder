n = gets.to_s.to_i64
ans = Array.new(24, 0_i64)

n.times do
  w, x = gets.to_s.split.map(&.to_i64)
  24.times do |t|
    if 9 <= (t + x) % 24 < 18
      ans[t] += w
    end
  end
end

puts ans.max