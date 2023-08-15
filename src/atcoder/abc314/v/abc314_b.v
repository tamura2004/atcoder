import lemoncmd.proconio { input }
import arrays

struct Player {
	id int
	c int
	a []int
}

n := input[int]()
mut players := []Player{ cap: n }
for i := 0; i < n; i++ {
	c := input[int]()
	a := input[[]int](len: [c])
	players << Player {
		id: i + 1
		c: c
		a: a
	}
}
x := input[int]()
mini := arrays.min(players.filter(x in it.a).map(it.c)) or {
	println(0)
	exit(0)
}
ans := players.filter(x in it.a && it.c == mini)
println(ans.len)
println(ans.map(it.id.str()).join(" "))
