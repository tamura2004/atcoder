require "crystal/balanced_tree/treap/ordered_set"

t = [4, 5, 3, 3, 1, 1, 2].to_orderedset_sum
pp t.acc_upper(2)
pp t.acc_lower(2)

pp! t.size
pp! t.to_a
s = t ^ 3
pp! s
pp! s.acc

pp! t