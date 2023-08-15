// // s := "AtCoder"
// // println(s.to_lower())
// // println(s.to_upper())

import lemoncmd.proconio { input }

pub struct Query {
	t int
	x int
	c string
}

_ := input[int]()
// mut s := input[string]().split("")
_ := input[string]()

mut s := ["a"].repeat(500_000)
q := input[int]()
qs := input[[]Query](len: [q])

// mut qs := []Query{}
// mut used := false
// for query in input[[]Query](len: [q]).reverse() {
// 	if query.t == 1 {
// 		qs << query
// 	} else if !used {
// 		used = true
// 		qs << query
// 	} 
// }

for query in qs {
	match query.t {
		1 {
			s[query.x - 1] = query.c
		}
		2 {
			s = s.join("").to_lower().split("")
		}
		else {
			s = s.join("").to_upper().split("")
		}
	}
}

println(s.join(""))
