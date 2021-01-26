l,n = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i }

cnt = a.map do |i|
  [i,l-i].sort
end

mini = cnt.map(&.first).max
maxi = cnt.map(&.last).max
puts "#{mini} #{maxi}"