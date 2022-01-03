# Moodle Image

This image includes a default config.php files configurable using Docker environment variables and sentry integração for bug identification and for performance monitoring. A example of how you can use this image is available on [here](https://github.com/cte-zl-ifrn/moodle__install__ifrn).

## How to buid at local host?

```bash
./build.sh 3.11.4_001
```

## How to buid and release to Docker Hub using GitHub Action?

Create a new tag with Moodle version name.

## How to use?

### Using docker image

Run new image

```bash
docker run -p 8080:80 ctezlifrn/moodle:3.11.4_001
```


### Using Dockerfile

Create a `Dockerfile`

```Dockerfile
FROM ctezlifrn/moodle:3.11.4_001
```

Build the `Dockerfile`

```bash
docker build . -t my/moodle:3.11.4_001
```

Run new image

```bash
docker run -p 8080:80 my/moodle:3.11.4_001
```


