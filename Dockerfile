# build
FROM maven:3-jdk-11 as build
COPY . ./
WORKDIR boxfuse-sample-java-war-hello
RUN mvn package
#
# run tomcat
FROM tomcat:10.0-jdk11-openjdk
COPY --from=build /boxfuse-sample-java-war-hello/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080


