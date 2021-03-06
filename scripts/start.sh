#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

IDLE_PORT=$(find_idle_port)
REPOSITORY=/home/ec2-user/app/step4
PROJECT_NAME=miniproject

echo "> Build 파일 복사"
echo "> cp $REPOSITORY/zip/*.jar $REPOSITORY/"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

#echo "> yes |cp -arpf $REPOSITORY/zip/dockerfile $REPOSITORY/"
#
#yes |cp -arpf $REPOSITORY/zip/dockerfile $REPOSITORY/

#echo "> yes |cp -arpf $REPOSITORY/zip/docker-compose.yml $REPOSITORY/"
#
#yes |cp -arpf $REPOSITORY/zip/docker-compose.yml $REPOSITORY/

#echo "> docker-compose down"
#
#docker-compose down
#
#echo "> docker-compose up -d"
#
#docker-compose up -d

echo "> 새 어플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"

IDLE_PROFILE=$(find_idle_profile)

echo "> $JAR_NAME 를 profile=$IDLE_PROFILE 로 실행합니다."

cd $REPOSITORY
docker build -t spring ./


echo "> docker run -it --name $IDLE_PROFILE -d -e active=$IDLE_PROFILE -p $IDLE_PORT:$IDLE_PORT spring"

docker run -it --name "$IDLE_PROFILE" -d -e active=$IDLE_PROFILE -p $IDLE_PORT:$IDLE_PORT spring