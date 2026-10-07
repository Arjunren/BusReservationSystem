FROM maven:3.9.16-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src src
RUN mvn -q package
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/bus-reservation-system-1.0.0.jar app.jar
RUN useradd --create-home appuser && chown -R appuser:appuser /app
USER appuser
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
