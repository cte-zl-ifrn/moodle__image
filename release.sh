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
    echo "                  ./release.sh build 057"
    echo '       o   Push docker image and create git tag:'
    echo "                  ./release.sh push 057"
    echo '       o   Down, remove volumes, build docker image, recreate volumes, update docker-compose.yml and up:'
    echo "                  ./release.sh redeploy 057"
    exit
fi


OPERATION=$1
RELEASE_VERSION="$2"
FULL_IMAGE_NAME="registry.gitlab.com/zl-installs/zl-ava-installs/moodle:$RELEASE_VERSION"
# FULL_IMAGE_NAME="kelsoncm/moodle:$RELEASE_VERSION"

echo "$OPERATION $FULL_IMAGE_NAME"
if [ $OPERATION == "build" ]; then  
    docker build . -f Dockerfile --progress plain -t $FULL_IMAGE_NAME \
    && sed -i "s/moodle:.*$/moodle:$RELEASE_VERSION/g" docker-compose.yml
elif [ $OPERATION == "push" ]; then
    docker login registry.gitlab.com
    docker push $FULL_IMAGE_NAME
elif [ $OPERATION == "redeploy" ]; then
    ./release.sh build $2 \
    && ./release.sh push $2
else
    echo "Choose a valid command (build or push)"
fi