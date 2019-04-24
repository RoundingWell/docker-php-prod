# RoundingWell PHP-FPM

Docker container for PHP-FPM.

<https://hub.docker.com/r/roundingwell/php-fpm>

## Run

Requires a `/var/www/html` to be created in the container, either by mounting
a volume or copying files.

Exposes port `0.0.0.0:9000` as a fastcgi server.

## Build and Test

```bash
docker build .
docker run --rm -v $(pwd):/var/www/html $(docker images -q | head -1)
```
