a, b = gets.to_s.split.map(&.to_i64)

case
when 0 < a
  puts "Positive"
when 0 <= b
  puts "Zero"
else
  if (a..b).size.odd?
    puts "Negative"
  else
    puts "Positive"
  end
end
