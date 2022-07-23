l1,r1,l2,r2 = gets.to_s.split.map(&.to_i64)
r = (Math.max(l1,l2)...Math.min(r1,r2))
ans = r.size
# pp r
pp ans