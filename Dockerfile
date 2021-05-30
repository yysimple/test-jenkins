FROM adoptopenjdk/openjdk8-openj9:alpine-slim
EXPOSE 9999
MAINTAINER smallchill@163.com
WORKDIR /app
ADD /root/.jenkins/workspace/k8s/target/test-jenkins-latest.jar /app/app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]