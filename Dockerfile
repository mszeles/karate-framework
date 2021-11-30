#defining the base image
FROM maven:3.8.4-jdk-11

WORKDIR /usr/src/app
COPY pom.xml /usr/src/app
COPY ./src/test/java /usr/src/app/src/test/java

CMD mvn test