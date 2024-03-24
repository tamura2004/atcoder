s = gets.to_s
ans = s =~ /^\<\=+\>$/
puts ans ? :Yes : :No