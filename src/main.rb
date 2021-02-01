a = gets.chomp
a.gsub!(/I+/, "I")
a.gsub!(/O+/, "O")
a.gsub!(/^O/, "")
a.gsub!(/O$/, "")
puts a.size
