FROM maven:3-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml ./
COPY src src
RUN mvn package

FROM openjdk:17-alpine
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
COPY --from=build /app/target/*.jar ./
EXPOSE 8080
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar spring-petclinic.jar