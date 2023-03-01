n,a,b,c,d = gets.to_s.split.map(&.to_i64)
ans = ((b > 0 || c > 0) && (b - c).abs <= 1) || (b == 0 && c == 0 && (a == 0 || d == 0))
puts ans ? :Yes : :No