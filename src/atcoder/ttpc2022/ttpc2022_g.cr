n = gets.to_s.to_i
dn = gets.to_s.split.map(&.to_i64)
up = gets.to_s.split.map(&.to_i64)

mini = Int64::MIN
maxi = Int64::MAX

(1...n).each do |i|
  chmax mini, (dn[i] - up[0]) // i
  chmin maxi, (up[i] - dn[0]) // i
end

pp! [mini, maxi]