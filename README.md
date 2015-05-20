# Vagrant MEAN stack

MEAN - MongoDB, ExpressJS, AngularJS, NodeJS - based fullstack js framework using Vagrant.

Requirements
------------
* VirtualBox <http://www.virtualbox.com>
* Vagrant <http://www.vagrantup.com>
* Git <http://git-scm.com/>
* Cygwin <https://www.cygwin.com/> if using Windows for SSH and RSync compatibility

Usage
-----

### Configure Git
	$ git config --global user.email "YOUR_EMAIL_ADDRESS"
	$ git config --global user.name "YOUR_NAME"

### Startup
	$ git clone http://www.github.com/tomysmile/vagrant-mean-stack
	$ cd vagrant-mean-stack
	$ vagrant up --provider virtualbox

#### MongoDB
Externally the MongoDB server is available at port 8817, and when running on the VM it is available as a socket or at port 27017 as usual.

Package list
-----------------
* Ubuntu 14.04 64-bit
* MongoDB v3.0.0
* NodeJS v0.10.38 / NPM v2.10.0
* NPM: Express, Bower, Grunt-Cli, Yo