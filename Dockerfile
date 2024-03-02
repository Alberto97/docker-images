FROM --platform=linux/amd64 gradle:8.4.0-jdk21-jammy AS build
ARG KOTLIN_VERSION
ENV GRADLE_USER_HOME /cache
COPY build.gradle.kts gradle.properties settings.gradle.kts ./
RUN gradle --no-daemon build --stacktrace

FROM --platform=linux/amd64 debian:bookworm-slim
COPY --from=build /root/.konan/ /root/.konan/
