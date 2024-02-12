package usecase

import (
	"context"
)

type HealthUsecase struct{}

func NewHealthUsecase() *HealthUsecase {
	return &HealthUsecase{}
}

func (u *HealthUsecase) RespondHealth(ctx context.Context) map[string]string {
	return map[string]string{
		"message": "ok",
	}
}
