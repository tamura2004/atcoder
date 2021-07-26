package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const BUFSIZE = 10000000

var rdr *bufio.Reader

// 一行をstringで読み込み
func readline() string {
	buf := make([]byte, 0, 16)
	for {
		l, p, e := rdr.ReadLine()
		if e != nil {
			fmt.Println(e.Error())
			panic(e)
		}
		buf = append(buf, l...)
		if !p {
			break
		}
	}
	return string(buf)
}

// 一行を[]intで読み込み
func readIntSlice() []int {
	slice := make([]int, 0)
	lines := strings.Split(readline(), " ")
	for _, v := range lines {
		// s2iはstringをintに変換する関数(後述)
		slice = append(slice, s2i(v))
	}
	return slice
}

// string <-> int
func s2i(s string) int {
	v, ok := strconv.Atoi(s)
	if ok != nil {
		panic("Faild : " + s + " can't convert to int")
	}
	return v
}

func i2s(i int) string {
	return strconv.Itoa(i)
}

// bool <-> int
func b2i(b bool) int {
	if b {
		return 1
	}
	return 0
}

func i2b(i int) bool {
	return i != 0
}

func max(a int, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

func solve() {
	var n, k int
	fmt.Scan(&n, &k)
	a := readIntSlice()

	cnt := make(map[int]int)
	for i := 0; i < k; i++ {
		cnt[a[i]]++
	}

	ans := len(cnt)

	for i := k; i < n; i++ {

		cnt[a[i-k]]--
		if cnt[a[i-k]] == 0 {
			delete(cnt, a[i-k])
		}

		if _, ok := cnt[a[i]]; !ok {
			cnt[a[i]] = 1
		} else {
			cnt[a[i]]++
		}

		ans = max(ans, len(cnt))
	}

	fmt.Println(ans)
}

func main() {
	rdr = bufio.NewReaderSize(os.Stdin, BUFSIZE)
	solve()
}