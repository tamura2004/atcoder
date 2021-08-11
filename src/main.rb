a, b = gets.to_s.split.map { |v| v.to_i }
op = %w(== > <)[a <=> b]
puts [a, op, b].join(" ")
