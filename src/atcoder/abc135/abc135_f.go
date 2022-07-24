package main

import (
	"container/list"
	"fmt"
	"strings"
)

func ZAlgorithm(s string) []int {
	i := 1
	j := 0
	n := len(s)
	ans := make([]int, n)
	ans[0] = n

	for i < n {
		for i+j < n && s[j] == s[i+j] {
			j++
		}

		ans[i] = j

		if j == 0 {
			i++
			continue
		}

		k := 1

		for i+k < n && k+ans[k] < j {
			ans[i+k] = ans[k]
			k++
		}

		i += k
		j -= k
	}

	return ans
}

type Graph struct {
	n     int
	edges [][]int
	ind   []int
}

func NewGraph(n int) Graph {
	return Graph{
		n,
		make([][]int, n),
		make([]int, n),
	}
}

func (g Graph) Add(v, nv int) {
	g.edges[v] = append(g.edges[v], nv)
	g.ind[nv]++
}

func (g Graph) TSort() []int {
	ans := make([]int, 0)
	q := list.New()

	for v := 0; v < g.n; v++ {
		if g.ind[v] == 0 {
			q.PushBack(v)
		}
	}

	for q.Len() > 0 {
		v := q.Front().Value.(int)
		q.Remove(q.Front())
		ans = append(ans, v)

		for _, nv := range g.edges[v] {
			g.ind[nv]--
			if g.ind[nv] == 0 {
				q.PushBack(nv)
			}
		}
	}

	return ans
}

func main() {
	var s, t string
	fmt.Scan(&s)
	fmt.Scan(&t)

	n := len(s)
	m := len(t)

	if n < m {
		s = strings.Repeat(s, (m+n-1)/n)
	}

	cnt := ZAlgorithm(t + "@" + s + s)

	g := NewGraph(n)

	for v := 0; v < n; v++ {
		i := v + m + 1
		if cnt[i] == m {
			nv := (v + m) % n
			g.Add(v, nv)
		}
	}

	dp := make([]int, n)
	ts := g.TSort()

	if len(ts) < n {
		fmt.Println(-1)
	} else {
		for _, v := range ts {
			for _, nv := range g.edges[v] {
				dp[nv] = dp[v] + 1
			}
		}

		ans := 0
		for _, v := range dp {
			if ans < v {
				ans = v
			}
		}

		fmt.Println(ans)
	}
}
