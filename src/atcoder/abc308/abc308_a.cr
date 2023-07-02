# s = gets.to_s.split.map(&.to_i64)
# n = s.size
# if (0...n.pred).all?{|i|s[i] <= s[i+1]} && s.all?{|v|100<=v<=625} && s.all?(&.divisible_by?(25))
#   puts :Yes
# else
#   puts :No
# end

a = [1,2,3,4,5]
p *a