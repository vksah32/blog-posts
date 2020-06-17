# Setting up pi-cluster

#### 1. Install OS 
 - Download and flash Ubuntu 20.04 TLS for raspberry pi using balena etcher

- Install desktop on master

	 *Follow this [guide](https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview)*

Optional: Change default ubuntu user on master ([guide](https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-ubuntu-quickstart))

#### 2. Setup network for the cluster

#### 3. Set up Docker swarm

- Install docker and `docker-compose` ([guide](https://linuxconfig.org/how-to-install-docker-on-ubuntu-20-04-lts-focal-fossa)) on master and all slaves

	```bash
	#docker
	sudo apt install docker.io
	sudo systemctl enable --now docker
	
	#docker-compose
	
	sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	
	sudo chmod +x /usr/local/bin/docker-compose
	```

- Initialize swarm on master

	```bash
	docker swarm init --advertise-addr 10.0.0.1
	```

	It will print out a command for slaves to join the swarm; eg

	```
	docker swarm join --token <<some-token>> 10.0.0.1:2377
	```

- `ssh` into each slave and run the `swarm join` command

- [Optional] Run swarm visualizer on master

	```
	docker service create \
	  --name=viz \
	  --publish=8080:8080/tcp \
	  --constraint=node.role==manager \
	  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
	  alexellis2/visualizer-arm:latest
	```

	If you go to `masterip:8080` on your laptop, you should see

	![Screen Shot 2020-06-17 at 12.44.25 AM](https://raw.githubusercontent.com/vksah32/screenshots/master/Screen_Shot_2020-06-17_at_12.44.25_AM.png)

#### 3. Setup monitoring with grafana and prometheus



