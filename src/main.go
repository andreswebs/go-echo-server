package main

import (
	"fmt"
	"log"
	"net/http"
)

func rootHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "%s\n", r.URL.Path[1:])
}

const port = ":8080"

func main() {

	http.HandleFunc("/", rootHandler)

	log.Fatal(http.ListenAndServe(port, nil))

}
