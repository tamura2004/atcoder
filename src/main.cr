s = gets.to_s
x = gets.to_s.to_i64

y = 0_i64
i = 0

while i < s.size
  case s[i]
  when 'a'..'z'
    quit s[i] if x == y + 1
    y += 1
  when '0'..'9'
    d = s[i].to_i64
    if x <= (d + 1) * y
      x %= y
      x = y if x.zero?
      y = 0_i64
      i = 0
      next
    else
      y += d * y
    end
  end
  i += 1
end
