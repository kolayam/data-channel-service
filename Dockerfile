FROM maven
WORKDIR /usr/src/app
COPY . .
WORKDIR /usr/src/app/libs
RUN git clone https://github.com/kolayam/common.git
WORKDIR /usr/src/app
RUN mvn clean install -Dmaven.test.skip=true
FROM openjdk:8
COPY --from=0 /usr/src/app/data-channel-service/target/data-channel-service.jar ./
#ENV JAR=/usr/src/app/data-channel-service.jar
ENV PORT=9099
EXPOSE $PORT
RUN env
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "./data-channel-service.jar"]