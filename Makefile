BIN_NAME := gohello		# please change name you want
BIN_DIR := ./bin
X_BIN_DIR := $(BIN_DIR)/goxz
VERSION := $$(make -s app-version)

GOBIN ?= $(shell go env GOPATH)/bin

.PHONY: all
all: build

# Generate binaries suitable for the exec env
.PHONY: build
build:
	mkdir -p $(BIN_DIR)
	go build -o $(BIN_DIR)/$(BIN_NAME) main.go

# Generate and zip binaries suitable for each env for multiple platforms
.PHONY: x-build
x-build: $(GOBIN)/goxz
	goxz -d $(X_BIN_DIR) -n $(BIN_NAME) .

# Update generated binaries to GitHub release (only x-build)
.PHONY: upload-binary
upload-binary: $(GOBIN)/ghr
	ghr "v$(VERSION)" $(X_BIN_DIR)

# Output app version
.PHONY: app-version
app-version: $(GOBIN)/gobump
	@gobump show -r .

# Bump up major version
.PHONY: major-version
major-version:
	@gobump major -w -v -r .

# Bump up minor version
.PHONY: minor-version
minor-version:
	@gobump minor -w -v -r .

# Bump up patch version
.PHONY: patch-version
patch-version:
	@gobump patch -w -v -r .

.PHONY: push-tag
push-tag:
	git commit -m "Update: v$(VERSION)" && git tag v$(VERSION) && git push origin v$(VERSION)

# exec go install when each tool has not been installed
$(GOBIN)/goxz:
	@go install github.com/Songmu/goxz/cmd/goxz@latest

$(GOBIN)/ghr:
	@go install github.com/tcnksm/ghr@latest

$(GOBIN)/gobump:
	@go install github.com/x-motemen/gobump/cmd/gobump@master