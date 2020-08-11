.PHONY = all clean build_svc build_container push_container

SVC_NAME = ingrsvc

IMAGE_TAG = 1.0.0
IMAGE_NAME = ingrsvc
REGISTRY = fupas-main

PLATFORM_LINUX = GOARCH=amd64 GOOS=linux

all: clean build_svc build_container push_container

clean:
	rm build/${SVC_NAME}

build_svc: cmd/ingress/main.go
	cd cmd/ingress && ${PLATFORM_LINUX} go build -o ../../build/${SVC_NAME} main.go

build_container:
	docker build -t fupas/${IMAGE_NAME}:${IMAGE_TAG} .

push_container:
	docker tag fupas/${IMAGE_NAME}:${IMAGE_TAG} eu.gcr.io/${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
	docker push eu.gcr.io/${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}