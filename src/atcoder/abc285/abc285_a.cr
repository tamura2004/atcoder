a, b = gets.to_s.split.map(&.to_i64).sort
if a * 2 == b || a * 2 + 1 == b
  puts :Yes
else
  puts :No
end
