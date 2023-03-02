n = gets.to_s.to_i
s = Array.new(n){gets.to_s}

x = s.map(&.count('X').to_i64)
y = s.map(&.chars.select(&.!=('X')).sum(&.to_i64))

ix = (0...n).to_a.sort do |i, j|
  x[j] * y[i] <=> x[i] * y[j]
end

t = ix.map{|i|s[i]}.join

x_cnt = 0_i64
ans = 0_i64

t.chars.each do |c|
  case c
  when 'X'
    x_cnt += 1
  else
    ans += x_cnt * c.to_i64
  end
end

pp ans