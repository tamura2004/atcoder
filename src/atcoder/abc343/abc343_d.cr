require "crystal/balanced_tree/treap/tree_counter"
include BalancedTree::Treap

# t = TreeCounter{1 => 11_i64, 2 => 22_i64, 4 => 44_i64}
# pp t.size
# t[2] -= 22
# pp t.size

n, t = gets.to_s.split.map(&.to_i64)
a = Array.new(n, 0_i64)
st = TreeCounter(Int64, Int64).new
st[0] += n

t.times do
  i, b = gets.to_s.split.map(&.to_i64)
  i -= 1
  st[a[i]] -= 1
  a[i] += b
  st[a[i]] += 1
  pp st.size
end


