n = gets.to_s.to_i

n.times do |i|
  y = i + (i.even? ? 1 : -1)
  y = i if n.odd? && i == n - 1
  puts Array.new(n) { |x| y * n + x + 1 }.join(" ")
end
