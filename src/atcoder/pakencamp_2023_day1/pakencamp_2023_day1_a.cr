n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = a.tally.values.select(&.<= 10).size > 0
yesno ans
