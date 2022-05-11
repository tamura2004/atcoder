require "crystal/union_find"

uf = 10.to_uf

uf.unite 0,1
uf.unite 0,1
uf.unite 0,1
uf.unite 0,1
uf.unite 0,1

pp! uf.e_size[uf.find(0)]
pp! uf.e_size[uf.find(1)]
pp! uf.v_size[uf.find(0)]
pp! uf.v_size[uf.find(1)]
pp! uf.e_size[uf.find(2)]