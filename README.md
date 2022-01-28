# LXD Plutus Application Backend's Provisioning

## QuickStart

Build source material from Plutus Pioneer Program as easily as:

```
# 3rd Pioneer's cohort week 3 code given as an example

git clone https://github.com/input-output-hk/plutus-pioneer-program.git 
git clone git@github.com:grzegorznowak/lxd-pab.git lxd-pab
cd lxd-pab

# build PAB against the lesson's commit:
PAB_COMMIT=4edc082309c882736e9dec0132a3c936fe63b4ea ./converge.sh

# map the parent folder onto the container (a default you might need to tweak):
lxc config device add pab workspace disk source=$(pwd)/../ path=/home/nix/code
  
lxc exec pab -- sudo --login --user nix         # start interacting with the container as the nix user
cd ~/pab                                        # enter the PAB repo
nix-shell                                       # bootstrap the nix-shell
cd ~/code/plutus-pioneer-program/code/week03/   # go to the sources
cabal update                                    # update cabal
cabal build                                     # build
cabal repl                                      # bootstrap into REPL
```

## Requirements

Should work on any system that supports LXC/LXD containers

### LXD

do this only if you haven't yet bootstrapped any of `lxd` before

```
sudo snap install lxd
sudo lxd init --auto --storage-backend=dir
```

Other converge dependencies will be installed with the run of the `converge.sh` script

# PAB 

## Setup

### Converge

(will ask for sudo to install apt packets)

#### First time converge

This will get dependencies like `virtualenv` and `python` installed, bootstrapped and `molecule converge` ran
```
./converge.sh
```

#### Subsequent converges (or commit targeted builds)
At this point you should have the virtualenv and dependencies installed
so just bootstrap to it and roll with molecule directly

```
source provisioningenv/bin/activate

# converge against the default PAB commit
molecule converge -s lxd-pab  

# == OR == 
# converge against the specific commit 
# 3rd Pioneer's cohort week 3 commit given as an example:
PAB_COMMIT=4edc082309c882736e9dec0132a3c936fe63b4ea molecule converge -s lxd-pab
```
### Re-Converge

It's usually easy enough to destroy the container and converge it a new if something craps out.
The first part destroys the container, then runs the converge script all over again.

```
source provisioningenv/bin/activate
molecule destroy -s lxd-pab
molecule converge -s lxd-pab
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

## Map your workspace onto the container

```
lxc config device add pab workspace disk source=[your workspace's path] path=/home/nix/code
```

You can map either a containing folder with all your (Plutus) projects, or a specific project.
I suggest the former as it will make the whole setup so much more dynamic.
Then access it as `nix` user from that path given in the command itself: `/home/nix/code`


# Suggested Dev flow

Once you have your projects mapped interacting with the `PAB` is a matter of logging onto the container as the nix user
and executing commands as you would normally do, according to tutorials or to Plutus Programme

```
lxc exec pab -- sudo --login --user nix  # start interacting with the container as the nix user
cd pab                                   # enter the pab repo
nix-shell                                # bootstrap the nix-shell
cd ../code                               # now you're in the main folder with your projects 
                                         # and can follow along the training material
```

A top-up example assuming the pioneer's repo is already there in the projects' list
```
lxc exec pab -- sudo --login --user nix         # start interacting with the container as the nix user
cd pab                                          # enter the pab repo
nix-shell                                       # bootstrap the nix-shell
cd ~/code/plutus-pioneer-program/code/week01/   # 3rd cohort week 1 codes
cabal update                                    # update cabal
cabal build                                     # build
```

```
====
=========
This section is a work in progress as I go through the Plutus Pioneer's course.
=========
====
```

# Playground

* If not done yet, PAB has to be converged with either:
  * the default PAB_COMMIT with: `./converge.sh`
  * the specific PAB_COMMIT with: `PAB_COMMIT=4edc082309c882736e9dec0132a3c936fe63b4ea molecule converge -s lxd-pab`

* Start the server
`./playgound-server.sh`

* Let the server script complete

* In a separate terminal start the client
`./playgound-client.sh `

* Get the ip of the container running the playground:
```
PAB_IP=$(lxc list | grep pab | awk '{print $6}')
```
* the playground will be available from your browser under `http://${PAB_IP}:8009` 

# Haddock Documentation

```
# Get the public ip of the container
lxc list | grep pab | awk '{print $6}'  # show the PAB container's IP
./build-and-serve-docs.sh               # Start the haddock server
```

documentation will be available from your browser under `http://[PAB_IP]:8002/haddock`
