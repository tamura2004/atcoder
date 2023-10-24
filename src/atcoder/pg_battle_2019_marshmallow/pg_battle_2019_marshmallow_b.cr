s = gets.to_s
if s == "AtCoder"
    puts :Yes
elsif s.upcase == "ATCODER"
    puts :Maybe
else
    puts :No
end
