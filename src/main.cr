require "crystal/balanced_tree/treap/tree_counter"
include BalancedTree::Treap

t = TreeCounter(Int64,Int64).new

q = gets.to_s.to_i64
q.times do
  que, x, c = gets.to_s.split.map(&.to_i64) + [0_i64] * 2
  case que
  when 1 then t[x] += 1
  when 2 then t[x] -= c
  when 3 then pp (t.max - t.min)
  end
end
