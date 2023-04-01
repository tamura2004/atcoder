n, x = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort

if x == 0
  quit "Yes"
end

if x < 0
  x = -x
end

cnt = Set(Int64).new
n.times do |i|
  if cnt.includes?(a[i] - x)
    quit "Yes"
  end
  cnt << a[i]
end
puts "No"