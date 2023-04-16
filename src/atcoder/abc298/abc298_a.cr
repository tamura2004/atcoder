n = gets.to_s.to_i64
s = gets.to_s.chars.to_set

puts ('o'.in?(s) && !'x'.in?(s)) ? :Yes : :No