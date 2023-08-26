package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

var (
	scanner = bufio.NewScanner(os.Stdin)
	reader  = bufio.NewReader(os.Stdin)
	writer  = bufio.NewWriter(os.Stdout)
)

func nextInt() int {
	scanner.Scan()
	ret, _ := strconv.Atoi(scanner.Text())
	return ret
}

func nextStr() string {
	scanner.Scan()
	return scanner.Text()
}

// 可変文字列のラッパー
type MutableString struct {
	s []byte
}

// すべて大文字に
func (s MutableString) toUpper() {
	for i, c := range s.s {
		if c >= 97 {
			s.s[i] -= 32
		}
	}
}

// すべて小文字に
func (s MutableString) toLower() {
	for i, c := range s.s {
		if c < 97 {
			s.s[i] += 32
		}
	}
}

// １文字更新
func (s MutableString) update(i int, c byte) {
	s.s[i] = c
}

// 文字列へ
func (s MutableString) toStr() string {
	return string(s.s)
}

const (
	UPDATE = iota
	TO_LOWER
	TO_UPPER
)

// クエリ構造体
type Query struct {
	id int
	t  int
	x  int
	c  byte
}

// イニシャライザ
func NewQuery(i, t, x int, s string) Query {
	return Query{
		id: i,
		t:  t - 1,
		x:  x - 1,
		c:  ([]byte(s))[0],
	}
}

// クエリ処理
func (q Query) update(s MutableString, maxi int) {
	// maxiはTO_LOWER,TO_UPPERの最後のインデックス
	// 最後のみ実施してそれ以前は何もせずに戻る
	if q.t != UPDATE && q.id < maxi {
		return
	}

	switch q.t {
	case UPDATE:
		s.update(q.x, q.c)
	case TO_LOWER:
		s.toLower()
	case TO_UPPER:
		s.toUpper()
	}
}

// メイン処理
func main() {
	defer writer.Flush()

	var n, q int
	var _s string
	fmt.Fscan(reader, &n, &_s, &q)
	s := MutableString{[]byte(_s)}

	queries := make([]Query, q)
	maxi := -1

	// クエリ先読み
	// 種類2,3の最後のインデックスをmaxiに
	for i := 0; i < q; i++ {
		var t, x int
		fmt.Fscan(reader, &t, &x, &_s)
		queries[i] = NewQuery(i, t, x, _s)
		if t-1 != UPDATE {
			maxi = i
		}
	}

	// 最後のインデックスを渡してクエリ処理
	for _, q := range queries {
		q.update(s, maxi)
	}

	// 出力
	fmt.Fprintln(writer, s.toStr())
}
