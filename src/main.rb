st = gets.chomp.chars.tally
x = st["R"] - st["L"]
y = st["U"] - st["D"]

# st = gets.chomp.chars
# x = y = 0

# st.each do |ch|
#   case ch
#   when "L" then x -= 1
#   when "R" then x += 1
#   when "U" then y += 1
#   when "D" then y -= 1
#   else
#     puts "bad char: #{ch}"
#   end
# end

puts "#{x} #{y}"
