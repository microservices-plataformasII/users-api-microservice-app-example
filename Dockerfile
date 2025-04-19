FROM maven:3.8.4-openjdk-8 AS build
COPY pom.xml /app/pom.xml
COPY src /app/src
WORKDIR /app
RUN mvn clean install

# Run stage
FROM openjdk:8-jdk-alpine
COPY --from=build /app/target/users*.jar /app/app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]

