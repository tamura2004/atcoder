import os { get_line }

pub struct Query {
	t int
	x int
	c string
}

get_line()
mut s := get_line().split("")
q := get_line().int()

mut queries := []Query{}
for i := 0; i < q; i ++ {
	line := get_line().split(" ")
	t := line[0].int()
	x := line[1].int()
	c := line[2]
	queries << Query { t, x, c }
}

mut used := false
filtered := queries.reverse().filter(
	if it.t == 1 {
		true
	} else if used {
		false
	} else {
		used = true
		true
	}
).reverse()

for query in filtered {
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
