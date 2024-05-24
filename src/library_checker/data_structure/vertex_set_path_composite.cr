require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/st"
require "crystal/liner_function"

n, q = gets.to_s.split.map(&.to_i64)
g = n.to_g
values = Array.new(n) do
    a, b = gets.to_s.split.map(&.to_i64)
    F.new(a.to_m, b.to_m)
end
(n-1).times do
    v, nv = gets.to_s.split.map(&.to_i64)
    g.add v, nv, both: true, origin: 0
end
hld = HLDecomposition.new(g, 0)
st = ST(F).new(values) do |f, g|
    f + g
end

q.times do
    cmd, p, c, d = gets.to_s.split.map(&.to_i64)
    case cmd
    when 0
        st[p] = F.new(c.to_m, d.to_m) 
    when 1
        puts hld.path_query_with_st(p, c, st, edge: false)[d]
    end
end