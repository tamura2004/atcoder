n, m, d = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort.reverse
b = gets.to_s.split.map(&.to_i64).sort.reverse

i = j = 0
while i < n && j < m
  if (a[i] - b[j]).abs <= d
    quit a[i] + b[j]
  else
    if a[i] > b[j]
      i += 1
    else
      j += 1
    end
  end
end

puts -1