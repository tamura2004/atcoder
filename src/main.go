package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

func fileterFile(path string, info os.FileInfo, err error) error {
	if err != nil {
		log.Print(err)
		return nil
	}
	if !strings.HasSuffix(path, ".txt") {
		return nil
	}
	fh, err := os.Open(path)
	if err != nil {
		log.Print(err)
		return nil
	}
	defer fh.Close()

	ip := regexp.MustCompile(`\d+(\.\d+){3}`)
	scanner := bufio.NewScanner(fh)
	line_number := 0
	for scanner.Scan() {
		line := scanner.Text()
		line_number++
		if ip.MatchString(line) {
			fmt.Printf("%s:%d %s\n", path, line_number, line)
		}
	}
	return nil
}

func main() {
	err := filepath.Walk(".", fileterFile)
	if err != nil {
		log.Fatal(err)
	}
}
