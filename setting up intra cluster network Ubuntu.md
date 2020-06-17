# Setting up intra cluster network - Ubuntu

#### 1. Set up master's network

- Disable `cloud-init`  ([stack](https://askubuntu.com/questions/539277/how-to-get-rid-of-cloud-init), [docs](https://cloudinit.readthedocs.io/en/latest/topics/boot.html))

  ```
  sudo touch /etc/cloud/cloud-init.disabled
  ```

- Edit `nano /etc/netplan/50-cloud-init.yaml` (See this [stack](https://askubuntu.com/questions/1029531/how-to-setup-a-static-ip-on-ubuntu-server-18-04) for potential issues)

  ```yaml
  # This file is generated from information provided by the datasource.  Changes
  # to it will not persist across an instance reboot.  To disable cloud-init's
  # network configuration capabilities, write a file
  # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
  # network: {config: disabled}
  
  network:
      version: 2
      renderer: NetworkManager
      wifis:
          wlan0:
              dhcp4: true
              access-points:
                  "Wifi name":
                      password: "password"
      ethernets:
          eth0:
              dhcp4: no
              dhcp4-overrides:
                  use-routes: false
              addresses:
                  - 10.0.0.1/24
              nameservers:
                  addresses: [8.8.8.8, 4.4.4.4]
  ```

  - `sudo netplan generate`

  - `sudo netplan apply`

  	check if internet is working; if not google for solution.
  	
  	
#### 2. Install dhcp server

- Install disc-dhcp-server
	```bash
	apt-get install isc-dhcp-server
	```

- Setup config for dhcp server

	```bash
	nano /etc/dhcp/dhcpd.conf
	```
```
# dhcpd.conf
#
# Sample configuration file for ISC dhcpd
#
# Attention: If /etc/ltsp/dhcpd.conf exists, that will be used as
# configuration file instead of this file.
#

# option definitions common to all supported networks...
option domain-name "viveks.xyz";
option domain-name-servers 8.8.8.8, 8.8.4.4;

subnet 10.0.0.0 netmask 255.255.255.0 {
    range 10.0.0.1 10.0.0.10;
    option subnet-mask 255.255.255.0;
    option broadcast-address 10.0.0.255;
    option routers 10.0.0.1;
}
```

- Set default interfaces

	- Edit `/etc/default/isc-dhcp-server`
	- Set `INTERFACESv4="eth0"`

- Start/restart idc-dhcp server

	```
	sudo service isc-dhcp-server restart
	```

- Check status

	```
	sudo systemctl status isc-dhcp-server.service
	```


- Can see leases at `sudo cat /var/lib/dhcp/dhcpd.leases` but didnt show me all.



#### 3. Set up each slaves

- Enable ssh ([tutorial](https://linuxconfig.org/enable-ssh-on-ubuntu-20-04-focal-fossa-linux))

	```
	sudo systemctl enable --now ssh
	```

- Change hostname

	```
	sudo hostnamectl set-hostname new_hostname
	```

- Edit `/etc/hosts` => add `127.0.0.1 new_hostname` under `127.0.0.1 localhost`(will make sudo faster)

- Get mac address

	```
	ubuntu@slave1:~$ ip addr show
	
	...
	2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
	    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
	    inet 10.0.0.1/24 brd 10.0.0.255 scope global noprefixroute eth0
	       valid_lft forever preferred_lft forever
	    inet6 fe80::dea6:32ff:fe13:f8e7/64 scope link
	       valid_lft forever preferred_lft forever
	 ....
	```

	Record `xx:xx:xx:xx:xx:xx`; will be used to set static dhcp address on master


- Add ssh keys (from master to each) {later/optional} (Check this [tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2))

	```
	ssh-keygen -t rsa
	
	ssh-copy-id ubuntu@slave2
	ssh-copy-id ubuntu@slave1
	```

- Enable port forwarding to access internet

	
	- On masterpi
	
		 - Uncomment `net.ipv4.ip_forward=1` in `/etc/sysctl.conf` file. Need to reboot for this change to take effect; for immediate effect; do `sudo sysctl net.ipv4.ip_forward=1`
		
		 - Add following iptables rules; will route traffic from `eth0` to `wlan0`
		
			```bash
			sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
			sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
			sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
			
			```
		
		-  Check the iptables by running `iptables-save` command
		
		-  Install `iptables-persistent` to not have to add iptables rules all the time
		
			```bash
			sudo apt-get install iptables-persistent
			```
		
			(See [tutorial](https://upcloud.com/community/tutorials/configure-iptables-ubuntu/))

#### 4. Set up static DHCP license/ ip addresses for slaves

This is important in case the slaves restart and get a different ip from master's dhcp server; if you have hard-coded their ip in any system eg: prometheus; things will not work.

- Get mac address of each slave

- Update `/etc/dhcp/dhcp.conf`; final version should look like

```bash
option domain-name "viveks.xyz";
option domain-name-servers 8.8.8.8, 8.8.4.4;

subnet 10.0.0.0 netmask 255.255.255.0 {
    range 10.0.0.1 10.0.0.10;
    option subnet-mask 255.255.255.0;
    option broadcast-address 10.0.0.255;
    option routers 10.0.0.1;

    host slave1 {
       hardware ethernet <<mac-address-1>>;
       fixed-address 10.0.0.2;
    }

    host slave2 {
       hardware ethernet <<mac-address-2>>;
       fixed-address 10.0.0.3;
    }

}
	
```

#### 5. Update masterpi's hosts file



