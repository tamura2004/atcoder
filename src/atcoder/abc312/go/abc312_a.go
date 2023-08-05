package main

import (
	"fmt"
	"os"
)

func main() {
	chord := []string{"ACE", "BDF", "CEG", "DFA", "EGB", "FAC", "GBD"}
	var s string
	fmt.Scan(&s)

	for _, cho := range chord {
		if cho == s {
			fmt.Println("Yes")
			os.Exit(0)
		}
	}
	fmt.Println("No")
}
