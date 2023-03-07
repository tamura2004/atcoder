require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i)
es = Set(Tuple(Int32,Int32)).new
m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred).sort
  es << {v,nv}
end

q = gets.to_s.to_i
qs = Array.new(q) do |i|
  cmd, v, nv = gets.to_s.split.map(&.to_i)
  v, nv = nv, v unless v < nv
  v = v.pred
  nv = nv.pred
  {i,cmd,v,nv}
end

qs.each do |i,cmd,v,nv|
  case cmd
  when 1
    es << {v, nv}
  when 2
    es.delete({v, nv})
  end
end

uf = n.to_uf
es.each do |v, nv|
  uf.unite(v, nv)
end

ans = [] of Bool
qs.reverse_each do |i,cmd,v,nv|
  case cmd
  when 1
    es.delete({v, nv})
    uf = n.to_uf
    es.each do |v, nv|
      uf.unite(v, nv)
    end
  when 2
    uf.unite(v, nv)
    es << {v, nv}
  when 3
    ans << uf.same?(v, nv)
  end
end

puts ans.reverse.map{|v|v ? :Yes : :No}.join("\n")
