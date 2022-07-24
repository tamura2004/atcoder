package main

import (
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

func main() {
	var s string
	fmt.Scan(&s)

	ans := ZAlgorithm(s)
	fmt.Println(strings.Trim(fmt.Sprint(ans), "[]"))
}
