a = gets.to_s.split.map(&.to_i64)
n = a.size
c1 = (n-1).times.all?{|i|a[i] <= a[i+1]}
c2 = a.all?{|v|100<=v<=675}
c3 = a.all?{|v|v % 25 == 0}
puts c1 && c2 && c3 ? :Yes : :No