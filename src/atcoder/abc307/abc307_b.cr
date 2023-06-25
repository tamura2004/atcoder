def iskaibun(s)
  n = s.size
  (n//2).times.all? do |i|
    s[i] == s[n-1-i]
  end
end

n = gets.to_s.to_i64
s = Array.new(n){gets.to_s}

ans = false
n.times do |i|
  n.times do |j|
    next if i == j
    ans ||= iskaibun(s[i]+s[j])
  end
end

puts ans ? :Yes : :No