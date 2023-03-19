l, n1, n2 = gets.to_s.split.map(&.to_i64)
up = Array.new(n1) do
  Tuple(Int64,Int64).from gets.to_s.split.map(&.to_i64)
end.reverse

dn = Array.new(n2) do
  Tuple(Int64,Int64).from gets.to_s.split.map(&.to_i64)
end.reverse

vu = vd = -1
lu = ld = 0
ans = 0_i64

while up.size > 0 || dn.size > 0
  if lu.zero?
    vu, lu = up.pop
  end
  if ld.zero?
    vd, ld = dn.pop
  end

  lm = Math.min(lu,ld)
  if vu == vd
    ans += lm
  end

  lu -= lm
  ld -= lm
end

pp ans






