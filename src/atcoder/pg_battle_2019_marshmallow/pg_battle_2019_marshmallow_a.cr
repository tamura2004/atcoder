w, k, d = gets.to_s.split.map(&.to_i64)
ans = k <= d && (w - k) <= d
puts ans ? :Yes : :No