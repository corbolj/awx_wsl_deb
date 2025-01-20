#!/bin/bash

# Install Git
if ! which git &> /dev/null
then
    sudo apt install git -y
fi

# Stage playbook
if [ ! -f $HOME/projects/github.com/$USER/awx_wsl_deb/run.sh ]
then
    mkdir -p $HOME/projects/github.com/$USER/
    git clone https://github.com/corbolj/awx_wsl_deb.git $HOME/projects/github.com/$USER/awx_wsl_deb
    cd $HOME/projects/github.com/$USER/awx_wsl_deb
fi

# Install ansible
if ! which ansible-playbook &> /dev/null
then
    sudo apt update 
    sudo apt install ansible -y
fi

# Execute playbook
ansible-playbook -v --ask-become-pass playbook.yml
