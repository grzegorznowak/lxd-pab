# LXD Plutus Application Backend's Provisioning



## Requirements

### LXD

do this only if you haven't yet bootstrapped any of `lxd` before

```
sudo snap install lxd
sudo lxd init --auto --storage-backend=dir
```

Other converge dependencies will be installed with the run of the `converge.sh` script

## Setup

### Converge

(will ask for sudo to install apt packets)

```
./converge.sh
```

### Re-Converge

It's usually easy enough to just destroy the container and converge it a new if something craps out.
The first part destroys the container, then just runs the converge script all over again.

```
source provisioningenv/bin/activate
molecule destroy -s lxd-pab
./converge.sh
```

# Usage

## lookup the created container 
```
lxc list
```

it should be named `pab` on that list

At this point you have the PAB toolset installed inside the LXD container 
as the `nix` user. 

## Log onto the container as the nix user

```
lxc exec pab -- sudo --login --user nix
```

`PAB` sources from IOHK are checked out into ~/pab

## Accessing PAB while coding

```
====
=========
This section is a work in progress as I go through the Plutus Pioneer's course.
More of the actual use cases will follow
=========
====
```

## Playground

* Start the server
`./playgound-server.sh`

* In a separate terminal start the client
`./playgound-client.sh `

* get the ip of the container running the playground:
```
PAB_IP=$(lxc list | grep pab | awk '{print $6}')
```
now the playground will be available from your browser under `${PAB_IP}:8009` 


```
====
=========
This section is a work in progress as I go through the Plutus Pioneer's course.
More of the actual use cases will follow
=========
====
```
