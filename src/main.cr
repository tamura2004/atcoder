require "crystal/balanced_tree/treap/multiset"
l, q = gets.to_s.split.map(&.to_i64)
t = Multiset{0_i64, l}

q.times do
  c, x = gets.to_s.split.map(&.to_i64)
  case c
  when 1
    t << x
  when 2
    lo, hi = t.lower_upper(x).map(&.not_nil!)
    ans = hi - lo
    pp ans
  end
end
