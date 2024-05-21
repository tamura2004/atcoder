n,a,b = gets.to_s.split.map(&.to_i64)
puts (a-b).odd? ? :Borys : :Alice