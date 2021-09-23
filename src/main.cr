h, m, s = gets.to_s.split.map(&.to_i)
c1, c2 = gets.to_s.split.map(&.to_i)
h %= 12
min = max = -1
c = 0

while c1 >= 0
  s += 1

  if s == 60
    s = 0
    m += 1
    if m == 60
      m = 0
      h += 1
      if h == 12
        h = 0
      end
    end
  end

  if s == (m * 60 + 58) // 59
    c1 -= 1
  end

  if s == (h * 3600 - 660 * m + 10) // 11
    c2 -= 1
  end

  c += 1

  if c1 == 0 && c2 == 0
    next if h == 0 && m == 0 && s == 0
    if min == -1
      min = c
    end

    max = c
  end
end

if min == -1
  puts -1
else
  puts "#{min} #{max}"
end
