package main

import (
	"fmt"
	"os"
)

type Bag struct {
	i int
	a []bool
}

func NewBag(n int) *Bag {
	return &Bag{n - 1, make([]bool, n)}
}

func (b Bag) Pop() int {
	for b.a[b.i] {
		b.i--
	}
	b.a[b.i] = true
	return b.i
}

func (b Bag) Delete(i int) {
	b.a[i] = true
}

func main() {
	var n int
	fmt.Scan(&n)
	bag := NewBag(n*2 + 2)

	for {
		ball := bag.Pop()
		fmt.Println(ball)

		fmt.Scan(&n)
		if n == 0 {
			os.Exit(0)
		}
		bag.Delete(n)
	}
}
