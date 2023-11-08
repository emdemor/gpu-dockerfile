-include .env

export

PROJECT_NAME = gpu
PACKAGE_NAME = gpu

PWD := $(shell pwd)

DOCKER_IMG := $(PROJECT_NAME):latest
DOCKER_TORCH_IMG := $(PROJECT_NAME)_torch:latest
DOCKER_ENV := --env-file .env



DOCKER_TEST_IMG := $(PROJECT_NAME)_test:latest

DOCKER_RUN := docker run --rm -t

build:
	docker build -t $(DOCKER_IMG) .

start: build
	$(DOCKER_RUN) $(DOCKER_ENV) -i --gpus all $(DOCKER_IMG)

build-torch:
	docker build -f Dockerfile.torch -t $(DOCKER_TORCH_IMG) .

start-torch: build-torch
	docker run --rm $(DOCKER_ENV) -i --gpus all -p 8888:8888 -t $(DOCKER_TORCH_IMG)

shell-torch: build-torch
	docker run --rm $(DOCKER_ENV) -i --gpus all -p 8888:8888 -t $(DOCKER_TORCH_IMG) /bin/bash

nvidia-smi:
	$(DOCKER_RUN) $(DOCKER_ENV) -i --gpus all $(DOCKER_IMG) /usr/bin/nvidia-smi
