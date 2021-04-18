from numpy import*
H,W,N,M,*E=map(int,open(0).read().split())
n=N*2
G=zeros((H,W),"O")
E=array(E)-1
G[E[::2],E[1::2]]=1
G[E[n::2],E[n+1::2]]=2
F=G&0
for _ in"_"*4:F|=frompyfunc(lambda x,y:y or x,2,1).accumulate(G)
F=rot90(F)
G=rot90(G)
print(sum(F&1))