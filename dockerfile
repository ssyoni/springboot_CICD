FROM openjdk:11-jre-slim

WORKDIR /root

ARG JAR_FILE=./miniproject-1.0.1-SNAPSHOT.jar

COPY ${JAR_FILE} app.jar
COPY ${JAR_FILE} app.jar

CMD java -jar -Dspring.profiles.active=${active} app.jar