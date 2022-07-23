package main

import (
	"fmt"
)

type UnionFind struct {
	n    int
	par  []int
	rank []int
}

func NewUnionFind(n int) UnionFind {
	par := make([]int, n)
	rank := make([]int, n)

	for i := 0; i < n; i++ {
		par[i] = i
		rank[i] = 1
	}

	return UnionFind{n, par, rank}
}

func (uf UnionFind) Root(v int) int {
	if v == uf.par[v] {
		return v
	} else {
		root := uf.Root(uf.par[v])
		uf.par[v] = root
		return root
	}
}

func (uf UnionFind) Unite(v, nv int) {
	v = uf.Root(v)
	nv = uf.Root(nv)

	if v == nv {
		return
	}

	if uf.rank[nv] < uf.rank[v] {
		v, nv = nv, v
	}

	uf.par[v] = uf.par[nv]
	uf.rank[nv] += uf.rank[v]
}

func (uf UnionFind) Same(v, nv int) bool {
	return uf.Root(v) == uf.Root(nv)
}

func main() {
	var n, q int
	fmt.Scan(&n, &q)
	uf := NewUnionFind(n)

	var t, v, nv int

	for i := 0; i < q; i++ {
		fmt.Scan(&t, &v, &nv)
		if t == 0 {
			uf.Unite(v, nv)
		} else {
			ans := 0
			if uf.Same(v, nv) {
				ans = 1
			}
			fmt.Println(ans)
		}
	}
}
