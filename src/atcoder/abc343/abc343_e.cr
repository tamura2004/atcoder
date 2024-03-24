# 狭いのでgridを数える

v = gets.to_s.split.map(&.to_i64)
quit :No if v.zip(1..).map(&.product).sum != 3*7**3
pp :Yes