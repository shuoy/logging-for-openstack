#!/bin/bash

machine_type=$(echo $1 | tr '[:lower:]' '[:upper:]')
os_family=$(echo $2 | tr '[:lower:]' '[:upper:]')

printf "\n$machine_type\t$os_family\n\n"

rm -rf ./Vagrantfile
#source rc

if [ x$machine_type = xVAGRANT ]; then
  if [ x$os_family = xDEBIAN ]; then
    ln -s ./Vagrantfile.debian ./Vagrantfile
  elif [ x$os_family = xREDHAT ]; then
    ln -s ./Vagrantfile.redhat ./Vagrantfile
  else
    echo "Usage: run.sh [vagrant|physical] [debian|redhat(physical machine doesn't need)]"
    exit 2
  fi
  vagrant up
  export ANSIBLE_CONFIG=.ansible.cfg.vagrant
  ansible-playbook -i hosts_vagrant_ansible site.yml
elif [ x$machine_type = xPHYSICAL ]; then
  export ANSIBLE_CONFIG=.ansible.cfg.physical
  ansible-playbook -i hosts_physical_ansible site.yml
else
  echo "Usage: run.sh [vagrant|physical] [debian|redhat(physical machine doesn't need)]"
  exit 1
fi

