FROM maven:3.8.2-jdk-11-slim AS builder
RUN java -version
COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN mvn clean package --quiet
FROM eclipse-temurin:11-alpine
COPY --from=builder /usr/src/app/target/linksspurtree-0.0.1-SNAPSHOT.jar .
ENTRYPOINT ["java","-jar", "./linksspurtree-0.0.1-SNAPSHOT.jar"]