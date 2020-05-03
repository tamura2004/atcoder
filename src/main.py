x = 10
y = 20
cnt = dict()
for i in [x,y]:
    cnt[i] = 1

flag = True
for i in [x,y,100]:
    flag = flag and i in cnt

print(flag)
