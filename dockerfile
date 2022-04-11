FROM openjdk:11-jre-slim

WORKDIR /root

COPY ./miniproject-1.0.1-SNAPSHOT.jar .

CMD java -jar -Dspring.profiles.active=${active} miniproject-1.0.1-SNAPSHOT.jar