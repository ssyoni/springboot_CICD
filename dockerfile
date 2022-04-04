FROM openjdk:11-jre-slim

WORKDIR /root

ARG JAR_FILE=./build/libs/*.jar

COPY ${JAR_FILE} app.jar

CMD java -jar -Dspring.profiles.active=${active} app.jar