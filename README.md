Web server to run [cryptcheck](https://github.com/aeris/cryptcheck), without scheduling, database, cache.

Provide one API similar to the one cryptcheck.fr:
* ```/https/<host>.json```
* ```/https/<host>:<port>.json```

Result:
* If there is no error, a similar JSON structure is returned.
    ```json
    {"service":"https",
     "host":"<host>",
     "pending":false,
     "result": <cryptcheck result>,
     "created_at": "<date time>",
     "updated_at": "<date time>",
     "args": 443}
    ```
* If one argument is invalid, the HTTP status code is 400, a json
    ```json
    {"status":400,"error":"Invalid port","error_message":"<port> is not a number"}
    ```
* If cryptcheck triggers an exception, the HTTP status code is 503:
    ```json
    {"status":503,"error":"Address not available","error_message":"Address not available - connect(2) for [<ip>]:443"}
    ```
* If the host don't have an IPv6 connectivity:
    ```json
    {"service":"https","host":"<host>","pending":false,"result":[{"hostname":"<host>","port":443,"error":"Network unreachable - connect(2) for [<ipv6>]:443"}],"created_at":"<timestamp>","updated_at":"<timestamp>","args":443}
    ```

# Build docker image

```sh
make docker-build
```

# Run docker image

```sh
make docker-run
```

Or
```sh
docker run --rm -p 7000:7000 dalf/cryptcheck-backend:latest -o 0.0.0.0
```
