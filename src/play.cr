require "crystal/red_black_tree"

t = RedBlackTree.new
t.add 10
t.add 30
t.add 20
pp t.successor(t.search(20)).key
pp t.predecessor(t.search(20)).key
