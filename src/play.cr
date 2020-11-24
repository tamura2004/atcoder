n = gets.to_s.to_i64
m = n.to_s.size

ans = [] of Int64
1.upto(m*9) do |j|
  next if n - j < 0
  if (n - j).to_s.chars.map(&.to_i64).sum == j
    ans << n - j
  end
end

if ans.empty?
  puts 0
else
  puts ans.size
  puts ans.sort.join("\n")
end
