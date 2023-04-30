#!/usr/bin/env bash
if [ $# -lt 2 ]; then
    echo ''
    echo 'NAME '
    echo '       release.sh'
    echo 'SYNOPSIS'
    echo '       ./release.sh <operation> <moodle_version> <build_version>'
    echo 'DESCRIPTION'
    echo "       Build or push image."
    echo 'OPTIONS'
    echo '       <operation>      Operation: build | push | redeploy'
    echo '       <build_version>  Build version'
    echo 'EXAMPLES'
    echo '       o   Build docker image:'
    echo "                  ./release.sh build 030"
    echo '       o   Push docker image and create git tag:'
    echo "                  ./release.sh push 030"
    echo '       o   Down, remove volumes, build docker image, recreate volumes, update docker-compose.yml and up:'
    echo "                  ./release.sh redeploy 030"
    exit
fi

OPERATION=$1
RELEASE_VERSION="moodle4.1.3-php8.1-release001"
IMAGE_NAME="moodle:$RELEASE_VERSION.$2"
FULL_IMAGE_NAME="registry.gitlab.com/zl-installs/zl-ava-installs/$IMAGE_NAME"

echo "$OPERATION $FULL_IMAGE_NAME"
if [ $OPERATION == "build" ]; then  
    docker build . -f Dockerfile --progress plain --no-cache -t $FULL_IMAGE_NAME \
    && sed -i "s/moodle:.*$/$IMAGE_NAME/g" docker-compose.yml
elif [ $OPERATION == "redeploy" ]; then
    docker compose down \
    && sudo rm -rf volumes \
    && ./release.sh build $IMAGE_NAME \
    && git checkout volumes/ava/moodledata/filedir/.empty \
    && sudo chown -R www-data:www-data volumes/ava/moodledata \
    && sed -i "s/moodle:.*$/$IMAGE_NAME/g" docker-compose.yml \
    && docker compose up
elif [ $OPERATION == "push" ]; then
    docker push $FULL_IMAGE_NAME \
    && git tag $IMAGE_NAME \
    && git push origin $IMAGE_NAME \
    && git push --tags
else
    echo "Choose a valid command (build or push)"
fi