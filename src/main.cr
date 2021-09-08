require "crystal/rbst"

l, q = gets.to_s.split.map(&.to_i64)
tr = RBST(Int64).new
tr << 0_i64
tr << l

q.times do
  c, x = gets.to_s.split.map(&.to_i64)
  case c
  when 1
    tr << x
  when 2
    ans = tr.upper(x).not_nil! - tr.lower(x).not_nil!
    pp ans
  end
end
