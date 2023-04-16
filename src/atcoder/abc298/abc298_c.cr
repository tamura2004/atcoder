require "crystal/balanced_tree/treap/multiset"
require "crystal/balanced_tree/treap/ordered_set"
include BalancedTree::Treap

n = gets.to_s.to_i64
q = gets.to_s.to_i64

# n = 200000
# q = 200000

box = Array.new(n + 1) { Multiset(Int32).new }
card = Array.new(200_001) { OrderedSet(Int32).new }

q.times do |x|
  # cmd = i = j = 0
  # if x < 199990
  #   cmd = 1
  #   i = 100
  #   j = x
  # else
  #   cmd = 2
  #   i = 10
  # end

  cmd, i, j = gets.to_s.split.map(&.to_i) + [0]
  case cmd
  when 1
    box[j] << i
    card[i] << j
  when 2
    puts box[i].to_a.not_nil!.join(" ")
  when 3
    puts card[i].to_a.not_nil!.join(" ")
  end
end
