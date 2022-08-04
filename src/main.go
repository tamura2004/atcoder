package main

import (
	"bufio"
	"fmt"
	"os"
)

type SegmentTree struct {
	a []int
	n int
}

type ST = SegmentTree

func NewSegmentTree(values []int) *ST {
	st := new(ST)
	st.n = 1
	for st.n < len(values) {
		st.n <<= 1
	}
	st.a = make([]int, st.n<<1)
	for i, v := range values {
		st.a[i+st.n] = v
	}

	for i := st.n - 1; i > 0; i-- {
		st.a[i] = st.a[i<<1] ^ st.a[i<<1|1]
	}
	return st
}

func (st ST) Get(i int) int {
	i += st.n
	return st.a[i]
}

func (st ST) Set(i, v int) {
	i += st.n
	st.a[i] = v
	i >>= 1
	for i > 0 {
		lo := i << 1
		hi := lo | 1
		st.a[i] = st.a[lo] ^ st.a[hi]
		i >>= 1
	}
}

func (st ST) Fold(lo, hi int) int {
	lo += st.n
	hi += st.n

	left := 0
	right := 0

	for lo < hi {
		if lo&1 == 1 {
			left = left ^ st.a[lo]
			lo++
		}

		if hi&1 == 1 {
			hi--
			right = st.a[hi] ^ right
		}

		lo >>= 1
		hi >>= 1
	}
	return left ^ right
}

func main() {
	r := bufio.NewReader(os.Stdin)
	w := bufio.NewWriter(os.Stdout)
	defer w.Flush()

	var n, q, t, x, y int

	fmt.Fscan(r, &n, &q)

	a := make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Fscan(r, &a[i])
	}

	st := NewSegmentTree(a)

	for i := 0; i < q; i++ {
		fmt.Fscan(r, &t, &x, &y)
		x--
		if t == 1 {
			st.Set(x, st.Get(x)^y)
		} else {
			fmt.Fprintln(w, st.Fold(x, y))
		}
	}
}
