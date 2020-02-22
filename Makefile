docker-build:
	docker build . -t dalf/cryptcheck-backend:latest

docker-run:
	docker run --network host --name=cryptcheck-backend --rm -e SLOW_DOWN=0.1 -e BUG_METHOD_UNSUPPORTED_TIMEOUT=1 dalf/cryptcheck-backend:latest

docker-daemon:
	# BUG_METHOD_UNSUPPORTED_TIMEOUT:
	# see commit https://github.com/aeris/cryptcheck/commit/2f8509b6ed659624c7b60892642e426f8b3083a7
	# add https://github.com/aeris/cryptcheck/issues/49
	docker run -d --name=cryptcheck-backend --rm -e SLOW_DOWN=0.1 -e BUG_METHOD_UNSUPPORTED_TIMEOUT=1 -p 7000:7000 dalf/cryptcheck-backend:latest -o 0.0.0.0
