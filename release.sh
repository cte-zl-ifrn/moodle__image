#!/usr/bin/env bash
if [ $# -lt 3 ]; then
    echo ''
    echo 'NAME '
    echo '       release.sh'
    echo 'SYNOPSIS'
    echo '       ./release.sh <operation> <build_version> <moodle_version>'
    echo 'DESCRIPTION'
    echo "       Build or push $FULL_IMAGE_NAME."
    echo 'OPTIONS'
    echo '       <operation>      Operation: build | push'
    echo '       <build_version>  Build version'
    echo 'EXAMPLES'
    echo '       o   Build image:'
    echo "                  ./release.sh build 001 401"
    echo '       o   Push image:'
    echo "                  ./release.sh push 001 401"
    exit
fi

OPERATION=$1
BUILD_VERSION=$2
MOODLE_VERSION=$3
FULL_IMAGE_NAME="registry.gitlab.com/zl-installs/zl-ava-installs/plugins:$MOODLE_VERSION-$BUILD_VERSION"
FULL_IMAGE_NAME="registry.gitlab.com/zl-installs/zl-ava-installs/plugins:$MOODLE_VERSION-$BUILD_VERSION"

echo "$OPERATION $FULL_IMAGE_NAME"
if [ $OPERATION == "build" ]; then  
    docker build . -f Dockerfile.plugins.$MOODLE_VERSION --progress plain -t $FULL_IMAGE_NAME
elif [ $OPERATION == "push" ]; then
    docker push $FULL_IMAGE_NAME
else
    echo "Choose a valid command (build or push)"
fi