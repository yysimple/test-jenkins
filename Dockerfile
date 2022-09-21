FROM openjdk:8-jdk
LABEL maintainer=yysimple

# 加载参数
#ENV PARAMS="--server.port=8080 --spring.profiles.active=prod --spring.cloud.nacos.config.namespace=4b078c50-3380-4011-a5ab-c574c7dce056"
# RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

# 项目名称改一下
COPY target/*.jar /app.jar
EXPOSE 8080

ENTRYPOINT ["/bin/sh","-c","java -Dfile.encoding=utf8 -jar app.jar"]
