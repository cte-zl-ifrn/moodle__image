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

```
-l root
-L 2201:ifrn.ava.aberto.moodle:22
-L 2202:ifrn.ava.aberto.cron:22
-L 2203:ifrn.ava.aberto.db:22
-L 2204:ifrn.ava.portal:22
-L 2205:ifrn.ava.teste.db:22
-L 2206:ifrn.ava.teste.moodle:22
-L 2207:ifrn.ava.academico.moodle:22
-L 2208:ifrn.ava.academico.cron:22
-L 2209:ifrn.ava.academico.db:22
```

```bash
curl -X POST -H "Authentication: Token 1" -d ./moodle__local_suap/sync_up_enrolments_sample.json http://localhost:7080/local/suap/sync_up_enrolments.php 
```
