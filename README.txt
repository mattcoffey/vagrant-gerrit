Vagrant + Puppet Demo

Automatically downloads a CentOS VM image, starts it up using VirtualBox and runs a Puppet manifest which creates a custom welcome message
(requires x64 host machine)

Install Oracle VirtualBox for your host operating system

https://www.virtualbox.org/wiki/Downloads

Install Vagrant for your host operating system

http://downloads.vagrantup.com/

Run the example:

# Download the Vagrant and configuration files from my repository
git clone https://github.com/mattcoffey/vagrant.git

cd vagrant
# Download and startup the CentOS x64 VM and run puppet manifest
vagrant up

# Ssh into the newly started VM and see custom welcome message
vagrant ssh
