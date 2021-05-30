FROM adoptopenjdk/openjdk8-openj9:alpine-slim
EXPOSE 9999
MAINTAINER itman_cx@163.com
WORKDIR /app
ADD ./target/test-jenkins-latest.jar /app/app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]