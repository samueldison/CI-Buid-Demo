# syntax=docker/dockerfile:1

ARG BUILDER_IMAGE=bellsoft/liberica-openjdk-alpine:17.0.20.1
ARG RUNTIME_IMAGE=bellsoft/liberica-openjdk-alpine:17.0.20.1

FROM ${BUILDER_IMAGE} AS builder
WORKDIR /build
COPY target/*.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM ${RUNTIME_IMAGE} AS runtime


# ARG APP_VERSION=latest

LABEL org.opencontainers.image.title="DevSecOps-api" \
      org.opencontainers.image.description="Spring Boot API" \
      org.opencontainers.image.version="${APP_VERSION}"

WORKDIR /app
# Pull Alpine security fixes released after the base image was built
RUN apk upgrade --no-cache && \
    addgroup -S spring && adduser -S spring -G spring

COPY --chown=spring:spring --from=builder /build/dependencies/ ./
COPY --chown=spring:spring --from=builder /build/spring-boot-loader/ ./
COPY --chown=spring:spring --from=builder /build/snapshot-dependencies/ ./
COPY --chown=spring:spring --from=builder /build/application/ ./

USER spring:spring
EXPOSE 8084
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]

# ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
