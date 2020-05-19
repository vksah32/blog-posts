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

- list all stacks

  ```bash
  docker stack ls
  ```

- list services for a given stack 