docker-build:
	docker build . -t dalf/cryptcheck-backend:latest

docker-run:
	docker run --network host --name=cryptcheck-backend --rm -e SLOW_DOWN=1 dalf/cryptcheck-backend:latest

docker-daemon:
	docker run -d --name=cryptcheck-backend --rm -e SLOW_DOWN=1 -p 7000:7000 dalf/cryptcheck-backend:latest -o 0.0.0.0
