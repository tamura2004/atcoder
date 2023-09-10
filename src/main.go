package main

import (
	"fmt"
	"encoding/json"
)

type Race struct {
	Name string `json:"name"`
	Str int `json:"str"`
	Dex int `json:"dex"`
	Con int `json:"con"`
}

func main() {
	jsonBytes := []byte(`{"name":"human","str":8,"dex":8,"con":8}`)
	var r Race
	if err := json.Unmarshal(jsonBytes, &r); err != nil {
		panic(err)
	}
	fmt.Printf("%+v\n", r)
}