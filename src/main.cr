require "crystal/balanced_tree/treap/multiset"

enum R
  LO
  HI
end

ms = Multiset(Tuple(Int32,R)).new

n = gets.to_s.to_i64
n.times do
  lo, hi = gets.to_s.split.map(&.to_i)
  ms << {lo, R::LO}
  ms << {hi, R::HI}
end