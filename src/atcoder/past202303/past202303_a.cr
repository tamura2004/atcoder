n,s,t = gets.to_s.split.map(&.to_i64)
ans = n.odd?.to_unsafe ^ s ^ t
puts ans.zero? ? :Bob : :Alice