package main

import (
	"fmt"
)

func main() {
	const msg = "atcoder"
	var l, r int
	fmt.Scan(&l)
	fmt.Scan(&r)
	fmt.Println(msg[l-1 : r])
}
