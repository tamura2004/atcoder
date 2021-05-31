require "crystal/treap"

n,m = gets.to_s.split.map(&.to_i)
xy = Array.new(m) do
  x,y = gets.to_s.split.map(&.to_i)
  {x,y}
end
xy.sort!

t = Treap(Int32).new

t << n
xy.each do |x,y|
  if t.find(y)
    t.delete(y)
  end

  if t.find(y-1)
    t << y unless t.find(y)
  end

  if t.find(y+1)
    t << y unless t.find(y)
  end
end

pp t.cnt
pp t.find(0)
pp t.find(1)
