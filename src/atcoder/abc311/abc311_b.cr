n, d = gets.to_s.split.map(&.to_i64)
s = Array.new(n) { gets.to_s }

a = (0...d).map do |i|
  s.all? { |row| row[i] == 'o' } # 全員暇
end

ans = a.chunk(&.itself).select(&.first).to_a
if ans.empty?
  pp 0
else
  pp ans.map(&.last.size).max
end
