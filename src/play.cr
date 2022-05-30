require "crystal/implicit_treap"
alias Tree = ImplicitTreap(Int32)
tr = Tree{1,2}
pp tr.to_a
tr[1] = 3