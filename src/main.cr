l = gets.to_s.to_i
cnt = [] of Int32
while l > 1
  if l.odd?
    cnt << 1
  else
    cnt << 0
  end
  l //= 2
end

i = 1
unit = 1
ans = [] of Tuple(Int32,Int32,Int32)

while cnt.size > 0
  ans << {i,i+1,0}
  ans << {i,i+1,unit}
  unit *= 2
  
  v = cnt.pop
  if v == 1
    ans << {1,i+1,unit}
    unit += 1
  end

  i += 1
end

puts "#{i} #{ans.size}"
ans.each do |row|
  puts row.join(" ")
end


