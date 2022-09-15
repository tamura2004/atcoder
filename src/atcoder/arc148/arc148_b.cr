n = gets.to_s.to_i
s = gets.to_s
ans = s
i = s.index("p")

quit s if i.nil?

(i...n).each do |j|
  chmin ans, s[0...i] + s[i..j].reverse.tr("dp", "pd") + s[j + 1...n]
end

puts ans
