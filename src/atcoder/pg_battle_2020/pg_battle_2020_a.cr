n,x,a,b = gets.to_s.split.map(&.to_i64)
if n < x
  puts n * a
else
  puts n * b
end
