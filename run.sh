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
    UBUNTU_CODENAME=jammy
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
    sudo apt update 
    sudo apt install ansible -y
fi

# Execute playbook
ansible-playbook -v --ask-become-pass playbook.yml
