#!/bin/bash

# Determine if this machine has already been provisioned
# Basically, run everything after this command once, and only once
if [ -f ".vagrant_provision" ]; then 
    exit 0
fi

################################################################################
# Everything below this line should only need to be done once
# To re-run full provisioning, delete /home/vagrant/.vagrant_provision and re-run
#
#    $ vagrant reload --provision
#
################################################################################

function notify {
    printf "\n--------------------------------------------------------\n"
    printf "\t$1"
    printf "\n--------------------------------------------------------\n"
}

# Set parameters
host_name="vagrant-mean"

# Set Environment Varaibles
echo "Setting environment variables..."
echo "export NODE_ENV=development" >> /home/vagrant/.bashrc

if [ ! -f ".vagrant_provision_upg" ]; then
    notify "update & upgrade server"

	# Update the server
	apt-get update
	apt-get -y upgrade

	IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')
	sed -i "s/^${IPADDR}.*//" /etc/hosts
	echo $IPADDR ${host_name} >> /etc/hosts
	hostname ${host_name}

	touch .vagrant_provision_upg
fi

dpkg -s build-essential &>/dev/null || {
	notify "installing build tools.."
	apt-get -y install build-essential curl git-core ftp unzip python-software-properties python g++ libssl-dev
}

dpkg -s mongodb-org &>/dev/null || {
	notify "installing mongodb v3.0.0"
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb.list
	
	apt-get update
	apt-get install -y mongodb-org=3.0.0 mongodb-org-server=3.0.0 mongodb-org-shell=3.0.0 mongodb-org-mongos=3.0.0 mongodb-org-tools=3.0.0

	echo "mongodb-org hold" | dpkg --set-selections
	echo "mongodb-org-server hold" | dpkg --set-selections
	echo "mongodb-org-shell hold" | dpkg --set-selections
	echo "mongodb-org-mongos hold" | dpkg --set-selections
	echo "mongodb-org-tools hold" | dpkg --set-selections
}

dpkg -s nodejs &>/dev/null || {
	notify "installing nodejs v0.10"
	
	curl -sL https://deb.nodesource.com/setup | bash -
	apt-get install -y nodejs

	# upgrade NPM to latest v2.xx
	npm install -g npm

	notify "installing NPM base packages"

	#install base npm packages
	npm install -g bower
	npm install -g grunt-cli
	npm install -g express
	npm install -g yo
}

# Let this script know not to run again
touch .vagrant_provision