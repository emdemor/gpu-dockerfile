-include .env

export

PROJECT_NAME = gpu
PACKAGE_NAME = gpu

PWD := $(shell pwd)

DOCKER_IMG := $(PROJECT_NAME):latest
DOCKER_ENV := --env-file .env

DOCKER_RUN := docker run --rm -t

build:
	docker build -f Dockerfile -t $(DOCKER_IMG) .

start:
	docker run --rm $(DOCKER_ENV) -v ./project:/app/project -i --gpus all -p 8888:8888 -t $(DOCKER_IMG)

shell: build
	docker run --rm $(DOCKER_ENV) -v ./project:/app/project -i --gpus all -p 8888:8888 -t $(DOCKER_IMG) /bin/bash
