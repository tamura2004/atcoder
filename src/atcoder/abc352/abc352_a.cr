n,x,y,z=gets.to_s.split.map(&.to_i64)
x, y = y, x unless x < y
ans = z.in?(x..y)
yesno ans