n,w = gets.to_s.split.map(&.to_i64)
ab = Array.new(n) do
  Tuple(Int64,Int64).from gets.to_s.split.map(&.to_i64)
end.sort.reverse

ans = 0_i64
ab.each do |a,b|
  if w <= b
    ans += a * w
    puts ans
    exit
  else
    ans += a * b
    w -= b
  end
end

puts ans
