#dp[i][j] 圧縮後の長さがiで、圧縮前の長さがj
N,P=map(int,input().split())

dp=[[0]*(N+10) for i in range(N+10)]
dp[0][0]=1
dp[0][1]=-1
# 配るDP
for i in range(N+1):
	for j in range(N+1):
		dp[i][j]+=dp[i][j-1]
	for j in range(N+1):
		coef = 25 if j!=0 else 26
		for digit in range(1,5):
			# dp[i+1+digit][j+range]+=dp[i][j]
			if j+10**(digit-1)<=N:
				dp[i+1+digit][j+10**(digit-1)]=(dp[i+1+digit][j+10**(digit-1)]+dp[i][j]*coef)%P
			if j+10** digit   <=N:
				dp[i+1+digit][j+10** digit   ]=(dp[i+1+digit][j+10** digit   ]-dp[i][j]*coef)%P

print(sum(dp[i][N] for i in range(N))%P)