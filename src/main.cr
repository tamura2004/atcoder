require "crystal/union_find"

n,q = gets.to_s.split.map(&.to_i)
uf = (n*2).to_uf

q.times do
  w,x,y,z = gets.to_s.split.map(&.to_i64)
  x -= 1
  y -= 1

  case w
  when 1
    if z.even?
      uf.unite x, y
      uf.unite x+n, y+n
    else
      uf.unite x+n, y
      uf.unite x, y+n
    end
  when 2
    ans = uf.same?(x,y) || uf.same?(x+n,y+n)
    puts ans ? "YES" : "NO"
  end
end
