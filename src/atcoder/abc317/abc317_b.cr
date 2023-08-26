n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort

(n - 1).times do |i|
  if a[i + 1] - a[i] != 1
    quit a[i] + 1
  end
end
