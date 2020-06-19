# Docker things

### Simple case -> copy current directory and run a command

- write a dockerfile

  ```dockerfile
  FROM golang:1.14.3-alpine3.11
  ADD . ~/test
  WORKDIR ~/test/src/main
  CMD go run test.go  
  
  ```
  
- build it
	```bash
	docker build . -t test:latest
	```
- run it 
	```bash
	docker run -d test:latest
	```
  



## Common Docker  commands

- list all docker processes on a current machine

  ```bash
  docker ps
  ```

- show logs for container on the current machine

  ```bash
  docker logs {{container_name}}
  ```

- [Swarm] deploy a stack

  ```
  docker stack deploy --compose-file docker-compose.yaml stackdemo
  ```

  

- list all stacks

  ```bash
  docker stack ls
  ```

- list services for a given stack 

  ```bash
  docker stack services {{stack_name}}
  ```

- show logs for a docker process for a service in a stack

  ```bash
  docker service logs {{service_name}}
  ```


- Delete a stack

	```bash
	docker stack rm {{stack_name}}
	```

- Restart docker on a node

	```bash
	docker systemctl stop docker
	docker systemctl start docker
	
	
	```

	