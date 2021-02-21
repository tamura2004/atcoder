n,q = gets.to_s.split.map { |v| v.to_i }
a = Array.new(n) do
  year,name = gets.to_s.split
  year = year.to_i
  {year,name}
end
a << {0,"kogakubu10gokan"}
a.sort!.reverse!
ans = a.bsearch{|year,name| year <= q}.not_nil!
puts ans[1]