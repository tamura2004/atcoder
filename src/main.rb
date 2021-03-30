n = gets.to_s.to_i
s = gets.chomp

cnt = []
n.times do |i|
  cnt << s[i...n]
end

pp cnt

ans = (1...n).to_a.sort do |i,j|
  cnt[i] + cnt[j] <=> cnt[j] + cnt[i]
end