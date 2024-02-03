n = gets.to_s.to_i64
taka, aoki = Array.new(n){gets.to_s.split.map(&.to_i64)}.transpose.map(&.sum)

case
when taka == aoki
  puts :Draw
when taka < aoki
  puts :Aoki
else
  puts :Takahashi
end

