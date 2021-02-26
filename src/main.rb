pat = 10.times.map do |i|
  [4,1,2,3].map do |j|
    (i**j)%10
  end
end

a,b,c = gets.to_s.split.map{ |v| v.to_i }
m = b.pow(c, 4)
ans = pat[a%10][m]
puts ans
