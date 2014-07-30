#!/bin/bash

# Run the playbook on to the corresponding VMs
export ANSIBLE_CONFIG=.ansible.cfg
ansible-playbook -i hosts site.yml
