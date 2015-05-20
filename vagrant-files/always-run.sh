#!/bin/bash
echo "Run 'vagrant ssh' then set your git config manually:"
echo "ssh-keygen -t rsa"
echo "(Copy the contents of ~/.ssh/id_rsa.pub into your GitHub account: https://github.com/settings/ssh)"
echo "git config --global user.name '<your name>'"
echo "git config --global user.email <your email>"

printf "\n--build v1.0.0--\n\n"