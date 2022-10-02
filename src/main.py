N=int(input())
A=set(map(int,input().split()))
print(A)

l=0
r=N+1
while r-l>1:
  m=(l+r)//2
  # m巻まで読めるか?
  c=len(set(range(1,m+1))&A)
  if c+(N-c)//2>=m: l=m
  else: r=m

print(l)
