#!/bin/bash

# Run the playbook on to the corresponding VMs
#source rc
ansible-playbook -i hosts_test site.yml
