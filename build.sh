#!/usr/bin/env bash

FULL_IMAGE_NAME="ctezlifrn/moodle"

if [ $# -eq 0 ]; then
  echo ''
  echo 'NAME '
  echo '       build.sh'
  echo 'SYNOPSIS'
  echo '       ./build.sh <moodle_version>_<build_version>'
  echo 'DESCRIPTION'
  echo "       Build $FULL_IMAGE_NAME image locally."
  echo 'OPTIONS'
  echo '       <moodle_version> Moodle version'
  echo 'EXAMPLES'
  echo '       o   Build a image to local usage only:'
  echo "                  ./build.sh 3.11.4_003"
  exit
fi

RELEASE_VERSION=$1
docker image rm -f $FULL_IMAGE_NAME:$RELEASE_VERSION
docker build . --progress plain --no-cache -t $FULL_IMAGE_NAME:$RELEASE_VERSION --build-arg RELEASE_VERSION=$RELEASE_VERSION
