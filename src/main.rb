n,m = gets.to_s.split.map{ |v| v.to_i }

hh = 360.0 / 12 * (n % 12) + 360.0 / 12 / 60 * m
mm = 360.0 / 60 * m

ans = hh - mm
ans += 360.0 if ans < 0
ans = 360 - ans if ans > 180

pp ans