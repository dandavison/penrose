IMAGE_NAME:=penrose
CONTAINER_NAME:=$(IMAGE_NAME)

.PHONY: build
build: Dockerfile
	docker build -t $(IMAGE_NAME) .

.PHONY: run
run: build
	docker run -it --volume=$(PWD)/src:/penrose/src -p 8000:8000 -p 9160:9160 --rm --name $(CONTAINER_NAME) $(IMAGE_NAME)

.PHONY: run-shell
run-shell: build
	docker run -it --volume=$(PWD)/src:/penrose/src -p 8000:8000 -p 9160:9160 --rm --name $(CONTAINER_NAME) $(IMAGE_NAME) tmux

.PHONY: exec-shell
exec-shell:
	docker exec -it $(CONTAINER_NAME) tmux
