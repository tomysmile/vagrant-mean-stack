# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "vagrant-mean"
  
  config.vm.box_check_update = false
    
  config.vm.network "forwarded_port", guest: 80, host: 8880
  config.vm.network "forwarded_port", guest: 8080, host: 8888
  config.vm.network "forwarded_port", guest: 27017, host: 8817

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.56.102"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: [".git/","node_modules", "bower_components"]    

  # Provision script - run once
  config.vm.provision "shell", path: "provision.sh"
 
  # Provision script - run every vagrant up
  config.vm.provision "shell", path: "vagrant-files/always-run.sh"

end