# moodle

Como construir, publicar ou testar uma mudança na imagem.

Lembre-se de fazer login do `registry.gitlab.com`.

```bash
docker login registry.gitlab.com
```

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

```bash
sudo rm -rf volumes
mkdir -p volumes/ava/moodledata && touch volumes/ava/moodledata/.empty && chmod -R 777 volumes/ava/moodledata
docker compose up
curl -X POST -H "Authentication: Token 1" -d ./moodle__local_suap/sync_up_enrolments_sample.json http://localhost:7080/local/suap/sync_up_enrolments.php 
```

