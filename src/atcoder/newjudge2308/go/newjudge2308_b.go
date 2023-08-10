package main

import (
	"fmt"
	"math"
)

func main() {
	const msg = "atcoder"
	var n, k int
	fmt.Scan(&n)
	fmt.Scan(&k)
	for i := 0; i < k; i++ {
		n /= int(math.Pow10(i))
		q := n / 10
		r := n % 10
		if 5 <= r {
			q += 1
		}
		n = q * 10
		n *= int(math.Pow10(i))
	}
	fmt.Println(n)
}
