s = gets.to_s.chars.group_by(&.itself).transform_values(&.size)
maxi = s.values.max
ss = s.select{|k,v| v == maxi}.keys.sort.first
puts ss
