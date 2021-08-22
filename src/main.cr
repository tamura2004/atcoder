require "crystal/union_find_tree"

n,m = gets.to_s.split.map(&.to_i64)
uf = UnionFindTree.new(n)

m.times do
  l,r,d = gets.to_s.split.map(&.to_i64)
  l = l.to_i - 1
  r = r.to_i - 1

  if uf.same?(l, r)
    if uf.diff(l,r) != d
      puts "No"
      exit
    end
  else
    uf.unite(l,r,d)
  end
end

puts "Yes"