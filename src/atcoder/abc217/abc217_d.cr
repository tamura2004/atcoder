require "crystal/avl_tree"

l, q = gets.to_s.split.map(&.to_i64)
tr = [0_i64, l].to_avl

q.times do
  c, x = gets.to_s.split.map(&.to_i64)
  case c
  when 1
    tr << x
  when 2
    lo = tr.lower(x).not_nil!
    hi = tr.upper(x).not_nil!
    pp hi - lo
  end
end