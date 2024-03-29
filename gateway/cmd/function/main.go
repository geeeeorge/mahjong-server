package main

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"log"
)

type Request = events.APIGatewayWebsocketProxyRequest
type Response = events.APIGatewayProxyResponse

func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context, req Request) (Response, error) {
	// WebSocket接続IDを取得
	connectionID := req.RequestContext.ConnectionID

	// アクションによって処理を分岐
	if req.RequestContext.EventType == "CONNECT" {
		log.Printf("WebSocket connection established: %s", connectionID)
		return handleConnect()
	} else if req.RequestContext.EventType == "DISCONNECT" {
		log.Printf("WebSocket connection destroyed: %s", connectionID)
		return handleDisconnect()
	}

	// リクエストのボディをパース
	var requestBody map[string]interface{}
	err := json.Unmarshal([]byte(req.Body), &requestBody)
	if err != nil {
		return Response{StatusCode: 400}, fmt.Errorf("failed to parse request body: %v", err)
	}

	// action フィールドの値に基づいて処理を分岐
	switch action := requestBody["action"].(string); action {
	default:
		// 不明なアクションの場合の処理
		return Response{StatusCode: 400}, fmt.Errorf("unknown action: %s", action)
	}
}

// $connect アクションの処理
func handleConnect() (Response, error) {
	// 何か処理を行う
	return Response{StatusCode: 200}, nil
}

// $disconnect アクションの処理
func handleDisconnect() (Response, error) {
	// 何か処理を行う
	return Response{StatusCode: 200}, nil
}
