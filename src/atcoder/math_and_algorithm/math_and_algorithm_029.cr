require "crystal/matrix"

n = gets.to_s.to_i64
m = "1 1;1 0".to_mat
ans = m ** n
pp ans[0]
