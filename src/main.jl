function main()
	N = parse(Int, readline())
	X = zeros(Int, N, N)
	vis = zeros(Int, N, N)
	for i in 1:N, j in 1:N
		X[i,j] = min(i - 1, j - 1, N - i, N - j)
	end
	ans = 0
	for p = map(x->parse(Int, x), split(readline()))
		x = div(p - 1, N) + 1
		y = (p - 1) % N + 1
		ans += X[x,y]
		vis[x,y] = 1
		Q = Pair{Int,Int}[x => y]
		while !isempty(Q)
			nx, ny = popfirst!(Q)
			c = X[nx,ny]
			if vis[nx,ny] == 0
				c += 1
			end
			for (tx, ty) = [nx - 1 => ny,nx + 1 => ny,nx => ny - 1,nx => ny + 1]
				if 1 <= tx <= N && 1 <= ty <= N && X[tx,ty] > c
					X[tx,ty] = c
					push!(Q, tx => ty)
				end
			end
		end
	end
	println(ans)
end
main()