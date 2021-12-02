package main

import (
	"bytes"
	"flag"
	"io"
	"log"
	"os"

	"github.com/KMDMNAK/zip"
)

func main() {
	var (
		password = flag.String("p", "", "password")
	)
	flag.Parse()

	for _, input_file := range flag.Args() {
		contents, err := os.ReadFile(input_file)
		if err != nil {
			log.Fatalln(err)
		}

		fzip, err := os.Create(input_file + ".zip")
		if err != nil {
			log.Fatalln(err)
		}

		zipw := zip.NewWriter(fzip)
		defer zipw.Close()

		w, err := zipw.Encrypt(input_file, *password, zip.StandardEncryption)
		if err != nil {
			log.Fatal(err)
		}
		defer zipw.Flush()

		_, err = io.Copy(w, bytes.NewReader(contents))
		if err != nil {
			log.Fatal(err)
		}

		os.Remove(input_file)
	}
}
