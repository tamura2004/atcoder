import os { get_line }

fn get2() (int, int) {
	line := get_line().split(" ").map(it.int())
	return line[0], line[1]
}

struct Roulette {
	c int
	p int
	s []int
	z int
}

struct Problem {
	n int
	m int
mut:
	roulettes []Roulette
	memo []?f64
}

fn (mut problem Problem) dfs(x int) f64 {
	if x >= problem.m {
		return 0.0
	}

	if v := problem.memo[x] {
		return v
	}

	mut ans := 1e100
	for roulette in problem.roulettes {
		c := roulette.c
		p := roulette.p
		s := roulette.s
		z := roulette.z

		mut sum := 0.0
		for y in s {
			sum += problem.dfs(x + y)
		}
		cnt := (sum + p * c) / (p - z)
		if ans > cnt {
			ans = cnt
		}
	}
	problem.memo[x] = ans
	return ans
}

n, m := get2()
mut memo := []?f64 { len: m, init: none }

mut roulettes := []Roulette{}
for _ in 0 .. n {
	line := get_line().split(" ").map(it.int())
	c := line[0]
	p := line[1]
	s := line[2..].filter(it != 0)
	z := line[2..].filter(it == 0).len
	roulettes << Roulette { c, p, s, z }
}

mut problem := Problem {
	n: n,
	m: m,
	memo: memo,
	roulettes: roulettes
}

print(problem.dfs(0))