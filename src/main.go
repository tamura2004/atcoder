package main

type SegmentTree struct {
	a []int
	n int
}

func NewSegmentTree(n int) *SegmentTree {
	st := new(SegmentTree)
	st.n = 1
	for st.n < n {
		st.n <<= 1
	}
	st.a = make([]int, st.n<<1)
	return st
}
