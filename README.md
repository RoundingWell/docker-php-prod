# RoundingWell PHP-FPM

Docker container for PHP-FPM.

<https://hub.docker.com/r/roundingwell/php-fpm>

## Build and Test

```bash
docker build .
docker run docker run --rm -v $(pwd):/var/www/html $(docker images -q | head -1)
```
