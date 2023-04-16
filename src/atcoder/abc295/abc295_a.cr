dic = %w(and not that the you).to_set
n = gets.to_s.to_i64
words = gets.to_s.split.to_set
puts (dic & words).empty? ? :No : :Yes