package main

import (
	"bufio"
	"fmt"
	"os"
)

type UnionFind struct {
	n   int
	par []int
}

func NewUnionFind(n int) UnionFind {
	par := make([]int, n)

	for i := 0; i < n; i++ {
		par[i] = i
	}

	return UnionFind{n, par}
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

	uf.par[v] = uf.par[nv]
}

func (uf UnionFind) Same(v, nv int) bool {
	return uf.Root(v) == uf.Root(nv)
}

func YesNo(b bool) string {
	if b {
		return "Yes"
	} else {
		return "No"
	}
}

func main() {
	in := bufio.NewReader(os.Stdin)
	out := bufio.NewWriter((os.Stdout))
	defer out.Flush()

	var n, q int
	fmt.Fscan(in, &n, &q)
	uf := NewUnionFind(n)

	var t, v, nv int

	for i := 0; i < q; i++ {
		fmt.Fscan(in, &t, &v, &nv)
		if t == 0 {
			uf.Unite(v, nv)
		} else {
			fmt.Fprintln(out, YesNo(uf.Same(v, nv)))
		}
	}
}
