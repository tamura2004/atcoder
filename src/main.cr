require "crystal/log_num"

# include Math

# ans = LogNum.c(10, 3) * (LogNum.from(5) ** 3) / (LogNum.from(6) ** 10)
# ans2 = log(10) + log(9) + log(8) - log(3) - log(2) + (log(5)*3) - (log(6)*10)
# pp! ans
# pp! ans2
# pp! ans.to_num
# pp! ans.class

a = 10.00001
b = 9.999999

pp! a.round
pp! b.round