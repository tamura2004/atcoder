n = gets.to_s.to_i
xs = [] of Tuple(Int64,Int64,Int64)
ys = [] of Tuple(Int64,Int64,Int64)
n.times do 
  a, b = gets.to_s.split.map(&.to_i64)
  if a >= b
    xs << { (a - b).abs, a, b }
  else
    ys << { (a - b).abs, a, b }
  end
end

xs.sort!
ys.sort!

if xs.size.even?
  pp xs.sum(&.[1]) + ys.sum(&.[2])
else
  if ys.size.zero?
    ys << xs.shift
  elsif xs[0][0] < ys[0][0]
    ys << xs.shift
  else
    xs << ys.shift
  end
  pp xs.sum(&.[1]) + ys.sum(&.[2])
end



