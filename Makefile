ifdef RACE
	OPTS = -race -v
	else
	OPTS = -v
endif

all: clean vet test build

ci: clean vet bench build

vet:
	go vet ./...

lint:
	golint ./...

test:
	go test -cover ./...

build:
	go build $(OPTS) ./...

build-linux:
	GOOS=linux GOARCH=amd64 go build $(OPTS) ./...

bench:
	go test -cover --bench ./...

benchmark: bench

clean:
	go clean ./...

race:
	RACE=true make all

doc:
	godoc -http=:6060

update:
	govendor fetch +vendor

gen:
	go generate ./...
