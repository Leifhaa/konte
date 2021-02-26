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
- ```-p 8080:9999``` : Forwarding ports so a request on 8080 to our machine, is forwarded to port 9999 in the container
- ```'konte:latest'``` : Specifies which container image to run, following by which tag (latest in this case)

In summary, this command will start a container of the latest image on our local port 8080

#####Handling "404 not found"
In 

