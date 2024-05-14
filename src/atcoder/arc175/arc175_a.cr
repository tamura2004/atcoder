require "crystal/modint9"

n = gets.to_s.to_i64
p = gets.to_s.split.map(&.to_i.pred)
s = gets.to_s

# 全員が左で取る場合の場合の数
left = 1.to_m
seen = Array.new(n, false)
n.times do |i|
  if !seen[(p[i] + 1) % n]
    if s[p[i]] == 'R'
      left *= 0
    end
  else
    if s[p[i]] == '?'
      left *= 2
    end 
  end
  seen[p[i]] = true
end

# 全員が右で取る場合の場合の数
right = 1.to_m
seen = Array.new(n, false)
n.times do |i|
  if !seen[p[i] - 1]
    if s[p[i]] == 'L'
      right *= 0
    end
  else
    if s[p[i]] == '?'
      right *= 2
    end 
  end
  seen[p[i]] = true
end

ans = left + right
pp ans


