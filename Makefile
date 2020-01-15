docker-build:
	docker build . -t dalf/cryptcheck-backend:latest

docker-run:
	docker run --rm -p 8888:8888 dalf/cryptcheck-backend:latest
