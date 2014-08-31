#!/bin/bash
#generate hosts files for live servers in iiis-cluster

for i in {1..9};
do
	if ping -c 3 10.1.0.$i  2>&1; then
		echo "10.1.0.$i" >> ip_list
		echo "n00$i ansible_ssh_host=10.1.0.$i ansible_ssh_user=root" >> hosts_all
	elif ping -c 3 10.1.2.$i  2>&1; then
		echo "10.1.2.$i" >> ip_list
		echo "n00$i ansible_ssh_host=10.1.2.$i ansible_ssh_user=root" >> hosts_all
	fi
done

for i in {10..99};
do
	if ping -c 3 10.1.0.$i  2>&1; then
		echo "10.1.0.$i" >> ip_list
		echo "n0$i ansible_ssh_host=10.1.0.$i ansible_ssh_user=root" >> hosts_all
	elif ping -c 3 10.1.2.$i  2>&1; then
		echo "10.1.2.$i" >> ip_list
		echo "n0$i ansible_ssh_host=10.1.2.$i ansible_ssh_user=root" >> hosts_all
	fi
done

for i in {100..208};
do
	if ping -c 3 10.1.0.$i  2>&1; then
		echo "10.1.0.$i" >> ip_list
		echo "n$i ansible_ssh_host=10.1.0.$i ansible_ssh_user=root" >> hosts_all
	elif ping -c 3 10.1.2.$i  2>&1; then
		echo "10.1.2.$i" >> ip_list
		echo "n$i ansible_ssh_host=10.1.2.$i ansible_ssh_user=root" >> hosts_all
	fi
done
