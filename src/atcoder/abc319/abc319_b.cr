ans = [] of String
n = gets.to_s.to_i64

(n + 1).times do |i|
  (1..9).each do |j|
    next if n % j != 0
    if i % (n // j) == 0
      ans << j.to_s
      break
    end
  end
  if ans.size < i + 1
    ans << "-"
  end
end

puts ans.join
