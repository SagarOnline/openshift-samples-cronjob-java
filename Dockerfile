FROM openjdk:8-jre-alpine
ENV APP_FILE cronjob-1.0.jar
COPY target/cronjob-1.0.jar .
ENTRYPOINT ["java"]
CMD ["-jar", "./cronjob-1.0.jar"]