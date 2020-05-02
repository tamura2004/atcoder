n = read_line.to_i64
s = read_line.chomp

if n < 3
  puts 0
  exit
end

cnt = 0_i64
1.upto((n-1) // 2) do |d|
  (n - 2 * d).times do |i|
    j = i + d
    k = j + d
    if s[i] != s[j] && s[j] != s[k] && s[k] != s[i]
      cnt += 1
    end
  end
end

r = 0_i64
g = 0_i64
b = 0_i64
ans = 0_i64

n.times do |i|
  case s[i]
  when 'R'
    ans += g * b
    r += 1
  when 'G'
    ans += r * b
    g += 1
  when 'B'
    ans += r * g
    b += 1
  else
  end
end

p ans - cnt
