# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.define :gerrit do |config|
    config.vm.hostname = "gerrit"
    # Box to build off of.
    config.vm.box = "CentOS6.5"
    config.vm.box_url = "https://googledrive.com/host/0B4tZlTbOXHYWVGpHRWZuTThGVUE/centos65_virtualbox_50G.box"

    # Create a private network, which allows host-only access to the machine
    # using a static IP.
    config.vm.network :private_network, ip: "172.28.128.5", :netmask => "255.255.0.0", adapter: 2
    # Provision Docker via a shell script
    config.vm.provision "shell", :path => "deploy_docker.sh" do |s|
        s.args = "-i 172.28.128.5 -h gerrit"
    end
  end

  config.vm.network "forwarded_port", guest: 4243, host: 4243           # Docker daemon TCP
  config.vm.network "forwarded_port", guest: 8080, host: 8080           # Gerrit

  # Provider-specific configuration.
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.customize ["modifyvm", :id, "--cpus", 2]
  end
end
