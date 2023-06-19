require "crystal/implicit_treap"
alias Tree = ImplicitTreap

h, w = gets.to_s.split.map(&.to_i)
s = Array.new(h){gets.to_s}

tate = Tree.new((0...h).to_a)
yoko = Tree.new((0...w).to_a)

q = gets.to_s.to_i64
q.times do
  y, x = gets.to_s.split.map(&.to_i.pred)
  tate.reverse(..y)
  tate.reverse(y.succ..)
  yoko.reverse(..x)
  yoko.reverse(x.succ..)
end

h.times do |y|
  w.times do |x|
    i = tate[y]
    j = yoko[x]
    print s[i][j]
  end
  print "\n"
end
