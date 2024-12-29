# build base image

IMAGE=$(shell printf 'aic' | xxd -p)

up:
	docker compose -f ./docker/humble/docker-compose.yml -f ./docker/humble/nvidia.yml up
	docker compose -f ./docker/humble/docker-compose.yml -f ./docker/humble/nvidia.yml down
cpu-up:
	docker compose -f ./docker/humble/docker-compose.yml up
	docker compose -f ./docker/humble/docker-compose.yml down

code:
	@code --folder-uri vscode-remote://attached-container+$(IMAGE)/aichallenge/workspace/ -d

down:
	docker compose -f ./docker/humble/docker-compose.yml down

build:
	./scripts/build_docker_image.bash

cleanup-images:
	./scripts/cleanup_docker_images.bash