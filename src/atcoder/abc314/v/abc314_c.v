import lemoncmd.proconio { input }

n := input[int]()
m := input[int]()
s := input[string]().split("")
c := input[[]int](len: [n])
mut g := [][]int{len: m, init: []int{}}
mut ans := []string{len: n, init: ""}

for i, j in c {
	g[j - 1] << i
}

for row in g {
	k := row.len
	for i, ix in row {
		nix := row[(i + 1) % k]
		ans[nix] = s[ix]
	}
}

println(ans.join(""))