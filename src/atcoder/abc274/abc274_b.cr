h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s }
ans = Array.new(w, 0)

w.times do |j|
  h.times do |i|
    ans[j] += 1 if a[i][j] == '#'
  end
end

puts ans.join(" ")