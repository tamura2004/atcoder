n = 3
v1 = [1,3,-5]
v2 = [-2,4,1]

pp v1.sort.reverse.zip(v2.sort).map{|i,j|i*j}.sum
