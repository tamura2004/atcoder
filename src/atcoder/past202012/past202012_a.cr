s = gets.to_s
case
when s =~ /ooo/
  puts "o"
when s =~ /xxx/
  puts  "x"
else
  puts "draw"
end
