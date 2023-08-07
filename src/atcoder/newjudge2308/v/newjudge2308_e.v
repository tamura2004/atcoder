import lemoncmd.proconio { input }
import math.vec { Vec2 }
import datatypes { BSTree }

struct UnionFind {
	n int
	mut:
	parent []int
}

fn (mut u UnionFind) root(v int) int {
	if u.parent[v] == v {
		return v
	} else {
		u.parent[v] = u.root(u.parent[v])
		return u.parent[v]
	}
}

fn (mut u UnionFind) same(v int, nv int) bool {
	return u.root(v) == u.root(nv)
}

fn (mut u UnionFind) unite(v int, nv int) {
	u.parent[u.root(v)] = u.root(nv)
}

pub struct Pair {
	x int
	y int
}

fn (p Pair) ==(q Pair) bool {
	return p.x == q.x && p.y == q.y
}

fn (p Pair) <(q Pair) bool {
	if p.x < q.x {
		return true
	} else if p.x == q.x {
		return p.y < q.y
	} else {
		return false
	}
}

n := input[int]()
m := input[int]()
edges := input[[]Pair](len: [m])
k := input[int]()
restrictions := input[[]Pair](len: [k])
q := input[int]()
queries := input[[]Pair](len: [q])

mut parent := []int{}
for i in 0 .. n {
	parent << i
}
mut uf := UnionFind { n, parent }

for vec in edges {
	uf.unite(vec.x - 1, vec.y - 1)
}

mut good := BSTree[Pair]{}
for vec in restrictions {
	v := uf.root(vec.x - 1)
	nv := uf.root(vec.y - 1)
	good.insert(Pair{ v, nv })
	good.insert(Pair{ nv, v })
}
for vec in queries {
	v := uf.root(vec.x - 1)
	nv := uf.root(vec.y - 1)
	if good.contains(Pair{ v, nv }) {
		println("No")
	} else {
		println("Yes")
	}
}