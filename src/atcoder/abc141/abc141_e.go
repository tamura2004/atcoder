package main

import (
	"fmt"
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

func Min(a, b int) int {
	if a < b {
		return a
	} else {
		return b
	}
}

func ChMax(a *int, b int) {
	if *a < b {
		*a = b
	}
}

func main() {
	var n int
	var s string
	fmt.Scan(&n)
	fmt.Scan(&s)

	ans := 0

	for i := 0; i < n; i++ {
		cnt := ZAlgorithm(s[i:])

		for i, v := range cnt {
			ChMax(&ans, Min(i, v))
		}
	}
	fmt.Println(ans)
}
