package handler

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

func respondJSON(w http.ResponseWriter, r *http.Request, v interface{}) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")

	b, err := json.Marshal(v)
	if err != nil {
		log.Printf("encode response error: %v", err)
		return
	}

	w.WriteHeader(http.StatusOK)

	if _, err := fmt.Fprintf(w, "%s", b); err != nil {
		log.Printf("write response error: %v", err)
		return
	}
}
