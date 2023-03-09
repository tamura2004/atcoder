c = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

n = gets.to_s.to_i64
quit 0 if n.zero?

cnt = [] of Int64
3.times do
  q, r = n.divmod(36)
  cnt << r
  n = q
end

puts cnt.reverse.map{|i|c[i]}.join.gsub(/^0+/,"")

