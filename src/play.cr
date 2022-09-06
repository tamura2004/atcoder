require "crystal/graph"

g = Graph.new([4,[2,5,1,6],3])
pp g.to_sexp
g.each do |v|
  g.each(v) do |nv|
    puts "#{v.succ} - #{nv.succ}"
  end
end

