#!/bin/bash

for i in $(ls -1 inventories/*.ini)
do
    ansible-playbook generate_ssh_config.yml -i $i
done

cp ssh-config/templates/home-dir-dot-ssh/config-header.j2 ssh-config/dot-ssh-config-header

cat ssh-config/dot-ssh-config-header > ssh-config/dot-ssh-config
cat ssh-config/dot-ssh-config-host-* >> ssh-config/dot-ssh-config
rm -f ssh-config/dot-ssh-config-header ssh-config/dot-ssh-config-host-*

echo "Please copy ssh-config/dot-ssh-config to ~/.ssh/config. A recommended way of doing is to diff ssh-config/dot-ssh-config ~/.ssh/config and apply the changes"

