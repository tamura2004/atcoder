require "crystal/implicit_treap"
alias Tree = ImplicitTreap
a = Tree{10,20,30,40}
a.inv!

pp a