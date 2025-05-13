# Multi-stage Dockerfile for building the Student service with Gradle

# 1) Build stage: compile and assemble the Spring Boot JAR
FROM gradle:7.6.1-jdk11 AS builder
WORKDIR /home/gradle/project

# Copy Gradle wrapper and configuration for caching
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle settings.gradle ./

# Ensure wrapper is executable and download dependencies
RUN chmod +x gradlew && ./gradlew dependencies --no-daemon

# Copy source and build the Boot JAR (skip tests for speed)
COPY src src
RUN ./gradlew bootJar -x test --no-daemon

# 2) Run stage: minimal runtime
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the fat JAR from builder
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

# Expose the port
EXPOSE 8090

# Launch the application
ENTRYPOINT ["java","-jar","/app/app.jar"]
