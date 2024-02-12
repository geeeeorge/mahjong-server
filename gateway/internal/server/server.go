package server

import (
	"context"
	"github.com/geeeeorge/mahjong-server/internal/handler"
	"net"
	"net/http"
	"os/signal"
	"syscall"
)

type Server struct {
	health *handler.HealthHandler
}

func NewServer(h handler.Handlers) *Server {
	return &Server{
		health: h.Health,
	}
}

func (s *Server) Run(ctx context.Context, listener net.Listener) error {
	ctx, stop := signal.NotifyContext(ctx, syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	// TODO: websocketはactionsでhandleする
	server := &http.Server{Handler: http.HandlerFunc(s.health.GetHealth)}

	if err := server.Serve(listener); err != nil && err != http.ErrServerClosed {
		return err
	}

	<-ctx.Done()

	if err := server.Shutdown(context.Background()); err != nil {
		return err
	}

	return nil
}
