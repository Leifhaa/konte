#Multistage build:
#Step 1: Compile and build code:
FROM maven:3.6-jdk-11 as builder
#Define the working directory to /app.
#Any RUN, CMD, ADD, COPY or ENTRYPOINT commands will be executed in /app now.
WORKDIR /app

#Copy neccesairy source files
COPY pom.xml .
COPY src ./src

#Package with 1 thread per core
RUN mvn -T 1C package -DskipTests

#Step 2:
#Add compiled program to a bareboned OS which is capeable of running it
FROM adoptopenjdk/openjdk11:alpine-slim
WORKDIR /app
#Copy the .JAR file(s) from catalog to our container
COPY --from=builder /app/target/*.jar application.jar
#Setup how to run compiled program
ENTRYPOINT ["java", "-jar", "application.jar"]

