!#/bin/bash

os_family=$(echo $1 | tr '[:lower:]' '[:upper:]')
printf "$os_family \n\n"

# Cleanup the Vagrantfile that linked by previous run(s)
rm ./Vagrantfile

# Make a softlink so that Vagrant can work with the right OS
if [ $os_family = "DEBIAN" ]; then
  echo "Run Vagrant machines with Debian images"
  ln -s ./Vagrantfile.debian ./Vagrantfile
elif [ $os_family = "REDHAT" ]; then
  echo "Run Vagrant machines with CentOS images"
  ln -s ./Vagrantfile.redhat ./Vagrantfile
else
  echo "Usage: run.sh [debian|redhat]"
  exit 1
fi

#Create VMs if needed
vagrant up


# Run the Playbook on to the corresponding VMs
source rc
ansible-playbook -i hosts_test site.yml

