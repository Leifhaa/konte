Assignemnt can be found here:
https://github.com/PGR301-2020/konte

## Task 1 - Docker 
### Task A
This project contains a docker file for creating a Container Image of the spring boot application.
Run the following command to do so:
```bash
docker build . --tag konte
```

###Task B
In order to run a container of the newest container image, run the following command:
```bash
docker run -d --name hello-konte -p 8080:9999  konte:latest
```
#####Description of the arguments:
- ```-d``` : Run detached, means that docker container runs in the background of the terminal.
- ```--name hello-konte```: Assigns a name to the container, otherwise this name is randomly created.
- ```-p 8080:9999``` : Forwarding ports, so a request on 8080 to our machine, is forwarded to port 9999 in the container
- ```'konte:latest'``` : Specifies which container image to run, following by which tag (latest in this case)

In summary, this command will start a container of the latest image on our local port 8080

#####Handling "404 not found"
The original code would return a "404 not found" whenever run in container. Personally I experienced this due to index.html not being found inside the docker. This could be fixed in several ways:
########Option 1 - Adapting the docker file
Add the following command in stage 2 of the docker file:
```
FROM adoptopenjdk/openjdk11:alpine-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar application.jar
COPY index.html .                     (<------------- ADDED LINE)
ENTRYPOINT ["java", "-jar", "application.jar"]
```
This will copy the index.html into the app directory as well, and our application is able to access index.html when running in docker

########Option 2 - Moving the index.html file
Moving the index.html file inside src/main/resource/static would allow spring boot to serve the index.html by default without a need from a controller. Spring boot will automatically add static web sources located in such directory

I chose option 2 and removed the logic from the controller as this was no longer necessary. I interpreted that we're allowed to do such architectural changes. An argument for choosing option 2 is that I believe this is a more common way of serving static content, and this is how my previous classes has served static content.
Anther reason why I chose option 2 is that Option 1 doesn't scale well. If I'd want to add a new .html file, I'd also have to add a new COPY command inside docker file which opens for more errors.

After these changes, I was able to run & view the index page on http://localhost:8080/
There could also be other explainations why "404 not found" could occur when running the app in container. Some of the more common ones is:
- Trying to access http://localhost:9999/ instead of http://localhost:8080/
- Missing argument -p 8080:9999 when running ````docker run...```` 



