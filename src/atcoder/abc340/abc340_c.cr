require "crystal/balanced_tree/treap/ordered_set"
include BalancedTree::Treap

n = gets.to_s.to_i64
cnt = Hash(Int64, Int64).new(0_i64)
cnt[n] = 1_i64
set = OrderedSet{n}
ans = 0_i64

while set.size > 0
  v = set.pop
  ans += v * cnt[v]

  x = v // 2
  y = divceil(v, 2)

  if x >= 2
    cnt[x] += cnt[v]
    set << x
  end

  if y >= 2
    cnt[y] += cnt[v]
    set << y
  end
end

pp ans

