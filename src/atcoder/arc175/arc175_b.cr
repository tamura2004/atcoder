require "crystal/indexable"

n,a,b = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars.map { |c| c == '(' ? 1 : -1 }

sum = s.sum // 2
ans = b * sum.abs
if sum < 0
  i = 0
  while sum < 0
    if s[i] == -1
      s[i] = 1
      sum += 1
    end
    i += 1
  end
elsif sum > 0
  i = s.size - 1
  while sum > 0
    if s[i] == 1
      s[i] = -1
      sum -= 1
    end
    i -= 1
  end
end

cs = s.cs.min
if cs < 0
  ans += Math.min(a, b * 2) * divceil(cs.abs, 2)
end

pp ans
