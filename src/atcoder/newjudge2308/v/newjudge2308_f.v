import lemoncmd.proconio { input }

s := input[int]()
t := input[int]()
m := input[int]()

mut g := [][]int{ len: s, init: []int{} }
mut dp := [][]int{ len: t, init: []int{ len: t, init: -1 }}

for _ in 0 .. m {
	v := input[int]() - 1
	nv := input[int]() - 1 - s
	g[v] << nv
}

for v in 0 .. s {
	for x in g[v] {
		for y in g[v] {
			if x == y { continue }
			z := dp[y][x]
			if z == -1 {
				dp[y][x] = v
			} else {
				println('${v + 1} ${y + s + 1} ${x + s + 1} ${z + 1}')
				exit(0)
			}
		}
	}
}
println(-1)