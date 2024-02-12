FROM golang:1.20 as builder

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -o main cmd/function/main.go

FROM --platform=linux/amd64 public.ecr.aws/lambda/provided:al2

COPY --from=builder /src/main ./main

ENTRYPOINT [ "./main" ]
