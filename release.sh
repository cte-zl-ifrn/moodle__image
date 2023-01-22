#!/usr/bin/env bash
if [ $# -lt 3 ]; then
    echo ''
    echo 'NAME '
    echo '       release.sh'
    echo 'SYNOPSIS'
    echo '       ./release.sh <operation> <moodle_version> <build_version>'
    echo 'DESCRIPTION'
    echo "       Build or push $FULL_IMAGE_NAME."
    echo 'OPTIONS'
    echo '       <operation>      Operation: build | push | redeploy'
    echo '       <build_version>  Build version'
    echo 'EXAMPLES'
    echo '       o   Build docker image:'
    echo "                  ./release.sh build 401 010"
    echo '       o   Push docker image and create git tag:'
    echo "                  ./release.sh push 401 010"
    echo '       o   Down, remove volumes, build docker image, recreate volumes, update docker-compose.yml and up:'
    echo "                  ./release.sh redeploy 401 010"
    exit
fi

OPERATION=$1
MOODLE_VERSION=$2
BUILD_VERSION=$3
FULL_IMAGE_NAME="registry.gitlab.com/zl-installs/zl-ava-installs/moodle:$MOODLE_VERSION-$BUILD_VERSION"

echo "$OPERATION $FULL_IMAGE_NAME"
if [ $OPERATION == "build" ]; then  
    docker build . -f Dockerfile.$MOODLE_VERSION --progress plain -t $FULL_IMAGE_NAME \
    && sed -i "s/moodle:.*$/moodle:$MOODLE_VERSION-$BUILD_VERSION/g" docker-compose.yml
elif [ $OPERATION == "redeploy" ]; then
    docker compose down \
    && sudo rm -rf volumes \
    && ./release.sh build $MOODLE_VERSION $BUILD_VERSION \
    && git checkout volumes/ava/moodledata/filedir/.empty \
    && sudo chown -R www-data:www-data volumes/ava/moodledata \
    && sed -i "s/moodle:.*$/moodle:$MOODLE_VERSION-$BUILD_VERSION/g" docker-compose.yml \
    && docker compose up
elif [ $OPERATION == "push" ]; then
    docker push $FULL_IMAGE_NAME \
    && git tag $BUILD_VERSION \
    && git push origin $BUILD_VERSION
else
    echo "Choose a valid command (build or push)"
fi