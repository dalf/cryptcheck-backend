docker-build:
	docker build . -t dalf/cryptcheck-backend:latest

docker-run:
	docker run --rm -p 7000:7000 dalf/cryptcheck-backend:latest
