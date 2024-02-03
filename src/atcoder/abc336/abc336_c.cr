# ５進数
n = gets.to_s.to_i64.pred
ans = n.to_s(5).tr("01234", "02468")
puts ans

