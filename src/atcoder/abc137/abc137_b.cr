k, x = gets.to_s.split.map(&.to_i64)
lo = Math.max -1000000, x - k + 1
hi = Math.min 1000000, x + k - 1
puts (lo..hi).to_a.join(" ")
