require "crystal/segment_tree"

n, p, q, r = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
st = a.to_st_sum

# 閾を3つ動かすしゃく取り法
y = z = w = 0
pp = qq = rr = 0_i64

n.times do |x|
  while y < x || (y < n && pp + a[y] <= p)
    pp += a[y]
    qq -= a[y]
    # rr -= a[y]
    y += 1
  end

  while z < y || (z < n && qq + a[z] <= q)
    qq += a[z]
    rr -= a[z]
    z += 1
  end

  while w < z || (w < n && rr + a[w] <= r)
    rr += a[w]
    w += 1
  end

  if st[x...y] == p && st[y...z] == q && st[z...w] == r
    quit "Yes"
  end

  # pp! [x,y,z,w,pp,qq,rr]

  pp -= a[x]
end

puts "No"
  
  
