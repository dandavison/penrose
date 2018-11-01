IMAGE_NAME:=penrose
CONTAINER_NAME:=$(IMAGE_NAME)

# TODO: use repo belonging to penrose project
REPO:=dandavison7


.PHONY: build
build: Dockerfile
	docker build --file Dockerfile --tag $(IMAGE_NAME) ..


.PHONY: push
push: build
	docker tag $(IMAGE_NAME) $(REPO)/$(IMAGE_NAME)
	docker push $(REPO)/$(IMAGE_NAME)


.PHONY: pull
pull:
	docker pull $(REPO)/$(IMAGE_NAME)
	docker tag $(REPO)/$(IMAGE_NAME) $(IMAGE_NAME)


.PHONY: run-shell
run-shell: build
	docker run -it -p 8000:8000 -p 9160:9160 --entrypoint sh $(IMAGE_NAME)


.PHONY: exec-shell
exec-shell:
	docker exec -it $(CONTAINER_NAME) sh
