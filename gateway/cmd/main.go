package main

import (
	"context"
	"fmt"
	"github.com/geeeeorge/mahjong-server/internal/handler"
	"github.com/geeeeorge/mahjong-server/internal/server"
	"github.com/geeeeorge/mahjong-server/internal/usecase"
	"log"
	"net"
	"os"
)

func main() {
	log.Println("starting Mahjong server...")

	ctx := context.Background()

	if err := run(ctx); err != nil {
		log.Printf("error starting API server: %v", err)
		os.Exit(1)
	}
}

func run(ctx context.Context) error {
	//
	ln, err := net.Listen("tcp", fmt.Sprintf("%s:%d", "localhost", 8080))
	if err != nil {
		return fmt.Errorf("failed to listen on %s: %w", "localhost", err)
	}

	// usecase
	u := usecase.Usecases{
		Health: usecase.NewHealthUsecase(),
	}

	// handler
	h := handler.Handlers{
		Health: handler.NewHealthHandler(u.Health),
	}

	// server
	s := server.NewServer(h)

	log.Printf("listening on %s", ln.Addr().String())
	return s.Run(ctx, ln)
}
