s = gets.to_s
puts s =~ /^[A-Z][1-9][0-9]{5}[A-Z]$/ ? :Yes : :No