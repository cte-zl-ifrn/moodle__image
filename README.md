# moodle

Como construir, publicar ou testar uma mudança na imagem
```bash
NAME
       release.sh
SYNOPSIS
       ./release.sh <operation> <moodle_version> <build_version>
DESCRIPTION
       Build or push registry.gitlab.com/zl-installs/zl-ava-installs/moodle.
OPTIONS
       <operation>      Operation: build | push | redeploy
       <build_version>  Build version
EXAMPLES
       o   Build docker image:
                  ./release.sh build 401 001
       o   Push docker image and create git tag:
                  ./release.sh push 401 001
       o   Down, remove volumes, build docker image, recreate volumes, update docker-compose.yml and up:
                  ./release.sh redeploy 401 010
```