#!/bin/bash

# Determine if this machine has already been provisioned
# Basically, run everything after this command once, and only once
if [ -f ".vagrant_provision" ]; then 
    exit 0
fi

################################################################################
# Everything below this line should only need to be done once
# To re-run full provisioning, delete /home/vagrant/.vagrant-provision and re-run
#
#    $ vagrant provision
#
################################################################################

function notify {
    printf "\n--------------------------------------------------------\n"
    printf "\t$1"
    printf "\n--------------------------------------------------------\n"
}

# Set parameters
host_name="vagrant-mean"

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
	apt-get -y install build-essential curl git-core ftp unzip python-software-properties python g++ libssl-dev
}


# Let this script know not to run again
# touch .vagrant_provision