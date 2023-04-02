require "crystal/inversion_number"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)
quit "No" if a.sort != b.sort
quit "Yes" if a.uniq.size < n

b = b.zip(a).sort_by(&.last).map(&.first)
puts b.inversion_number.even? ? "Yes" : "No"
