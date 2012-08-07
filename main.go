package main

import (
	"fmt"
	"net/http"
)


func receive(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
}

func gather(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
}

func main() {
	http.HandleFunc("/receive", receive)
	http.HandleFunc("/gather", gather)
	http.ListenAndServe(":8089", nil)
}