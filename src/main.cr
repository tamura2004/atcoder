require "big"

enum OP
  P1X
  PAY
  PBZ
end

def solve(n,a,b,x,y,z)
  ba = a.to_big_i
  bb = b.to_big_i
  bx = x.to_big_i
  by = y.to_big_i
  bz = z.to_big_i

  ops = [
    {ba*bb*bx, OP::P1X},
    {bb*by, OP::PAY},
    {ba*bz, OP::PBZ}
  ]

  ans = 0_i64
  ops.sort.each do |cost, op|
    case op
    when .p1_x?
      ans += n * x
      n = 0_i64
    when .pay?
      ans += (n//a)*y
      n %= a
    when .pbz?
      ans += (n//b)*z
      n %= b
    end
  end
  ans
end

t = gets.to_s.to_i
t.times do
  n,a,b,x,y,z = gets.to_s.split.map(&.to_i64)
  pp solve(n,a,b,x,y,z)
end

