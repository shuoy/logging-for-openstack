#!/usr/bin/expect

set timeout 20
log_user 0

if { $argc != 3 } {
	send_user "\n$argv0 <user> <ip> <passwd>\n\n"
	exit 1
}

set username [lindex $argv 0]
set ip [lindex $argv 1]
set passwd [lindex $argv 2]
set sendpasswd 0

spawn ssh-copy-id $username@$ip

while 1 {
	expect {
		"Are you sure you want to continue connecting" {
			send "yes\r"
		}
		"*assword" {
			send "$passwd\r"
			set sendpasswd 1
		}
		"exist" {
			send_user "\[INFO\]The key already exists on remote system, try to login with \"ssh $username@$ip\"\n"
			exit
		}
		"Number of key(s) added" {
			send_user "\[INFO\]The key is installed successfully! Try to login with \"ssh $username@$ip\"\n"
			exit
		}
		"Host is down" {
			send_user "\[INFO\]The remote host $ip is down...Try to contact the cluster admin...\n"
			exit 1
		}
		timeout {
			if { $sendpasswd == 0 } {
				send_user "\[INFO\]The remote $ip host can't be accessed now!\n"
			} else {
				send_user "\[INFO\]The key is not installed on remote host $ip...Try to contact the cluster admin...\n"
			}
			exit 1
		}
	}
}
expect eof