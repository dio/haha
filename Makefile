BIN := build/bin/haha
REG ?= dio123
TAG ?= v1

ENVS := CGO_ENABLED=0 GOOS=linux
FLAGS := -a --ldflags '-extldflags "static"' -tags "netgo" -installsuffix netgo

$(BIN):
	$(ENVS) go build $(FLAGS) -o $@

clean:
	rm -f $(BIN)

docker-build: $(BIN)
	docker build -t $(REG)/haha:$(TAG) .

docker-run:
	docker run --rm -it -p 8080:8080 $(REG)/haha:$(TAG)

.PHONY: clean docker-build
